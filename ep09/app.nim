import os, sequtils, strutils
import nimgl/[glfw, opengl]

type
  ShaderProgramSource = object
    vertexSource: string
    fragmentSource: string

proc keyProc(window: GLFWWindow, key, scancode, action, mods: int32) {.cdecl.} =
  if key == GLFWKey.ESCAPE and action == GLFWPress:
    window.setWindowShouldClose(true)

proc checkShaderCompileStatus(id: uint32) =
  var status: int32
  glGetShaderiv(id, GL_COMPILE_STATUS, status.addr)
  if status == GL_FALSE.ord:
    var length: int32
    glGetShaderiv(id, GL_INFO_LOG_LENGTH, length.addr)
    var message = newSeq[char](length)
    glGetShaderInfoLog(id, length, length.addr, message[0].addr)
    echo "OpenGL Error: The shader compile operation failed. Error message: " &
      cast[string](message[0..^2])
    writeStackTrace()
    quit(QuitFailure)

proc checkProgramLinkStatus(id: uint32) =
  var status: int32
  glGetProgramiv(id, GL_LINK_STATUS, status.addr)
  if status == GL_FALSE.ord:
    var length: int32
    glGetProgramiv(id, GL_INFO_LOG_LENGTH, length.addr)
    var message = newSeq[char](length)
    glGetProgramInfoLog(id, length, length.addr, message[0].addr)
    echo "OpenGL Error: The program link operation failed. Error message: " &
      cast[string](message[0..^2])
    writeStackTrace()
    quit(QuitFailure)

proc parseShader(filepath: string): ShaderProgramSource =
  for part in filepath.readFile.split("#shader "):
    let split = part.split("\n", 1)
    case split[0]:
      of "vertex":
        result.vertexSource = split[1]
      of "fragment":
        result.fragmentSource = split[1]

proc compileShader(shaderType: GLenum, source: string): uint32 =
  result = glCreateShader(shaderType)
  var source = source.cstring
  glShaderSource(result, 1, source.addr, nil)
  glCompileShader(result)
  checkShaderCompileStatus(result)

proc createShader(ShaderProgramSource: ShaderProgramSource): uint32 =
  let vs = compileShader(GL_VERTEX_SHADER, ShaderProgramSource.vertexSource)
  let fs = compileShader(GL_FRAGMENT_SHADER, ShaderProgramSource.fragmentSource)

  result = glCreateProgram()
  glAttachShader(result, vs)
  glAttachShader(result, fs)
  glLinkProgram(result)
  checkProgramLinkStatus(result)

  glDeleteShader(vs)
  glDeleteShader(fs)

proc main =
  assert glfwInit()

  glfwWindowHint(GLFWContextVersionMajor, 3)
  glfwWindowHint(GLFWContextVersionMinor, 3)
  glfwWindowHint(GLFWOpenglForwardCompat, GLFW_TRUE)
  glfwWindowHint(GLFWOpenglProfile, GLFW_OPENGL_CORE_PROFILE)

  let window: GLFWWindow = glfwCreateWindow(640, 480, "Hello World")
  if window == nil:
    glfwTerminate()
    quit(QuitFailure)

  discard window.setKeyCallback(keyProc)
  window.makeContextCurrent

  assert glInit()

  echo "OpenGL version: ", cast[cstring](glGetString(GL_VERSION))
  echo "OpenGL renderer: ", cast[cstring](glGetString(GL_RENDERER))

  var positions = [
    -0.5f, -0.5,
    0.5, -0.5,
    0.5, 0.5,
    -0.5, 0.5,
  ]

  var indices = [
    0u32, 1, 2,
    2, 3, 0,
  ]

  var vao: uint32
  glGenVertexArrays(1, vao.addr)
  glBindVertexArray(vao)

  var buffer: uint32
  glGenBuffers(1, buffer.addr)
  glBindBuffer(GL_ARRAY_BUFFER, buffer)
  glBufferData(GL_ARRAY_BUFFER, 4 * 2 * sizeof(float32), positions[0].addr, GL_STATIC_DRAW)

  glEnableVertexAttribArray(0)
  glVertexAttribPointer(0, 2, EGL_FLOAT, false, 2 * sizeof(float32), nil)

  var ibo: uint32
  glGenBuffers(1, ibo.addr)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ibo)
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, 6 * sizeof(uint32), indices[0].addr, GL_STATIC_DRAW)

  let shaderProgramSource = parseShader(currentSourcePath.parentDir / "basic.shader")
  let shader = createShader(shaderProgramSource)
  glUseProgram(shader)

  while not window.windowShouldClose:
    glClear(GL_COLOR_BUFFER_BIT)

    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, nil)

    window.swapBuffers
    glfwPollEvents()

  glDeleteProgram(shader)
  window.destroyWindow
  glfwTerminate()

main()