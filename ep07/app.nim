import sequtils
import nimgl/[glfw, opengl]

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

proc compileShader(shaderType: GLenum, source: var cstring): uint32 =
  result = glCreateShader(shaderType)
  glShaderSource(result, 1, source.addr, nil)
  glCompileShader(result)
  checkShaderCompileStatus(result)

proc createShader(vertexShader, fragmentShader: var cstring): uint32 =
  let vs = compileShader(GL_VERTEX_SHADER, vertexShader)
  let fs = compileShader(GL_FRAGMENT_SHADER, fragmentShader)

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
    0.0, 0.5,
    0.5, -0.5
  ]

  # These extra lines are needed because I am using OpenGL's core profile
  # above (GLFW_OPENGL_CORE_PROFILE). This is explained in episode 12:
  # https://www.youtube.com/watch?v=Bcs56Mm-FJY&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=12
  # I am using the core profile because switching to using the compatability
  # pofile, GLFW_OPENGL_COMPAT_PROFILE, didn't seem to make a difference,
  # at least on macOS, and these lines were still be required.
  var vao: uint32
  glGenVertexArrays(1, vao.addr)
  glBindVertexArray(vao)

  var buffer: uint32
  glGenBuffers(1, buffer.addr)
  glBindBuffer(GL_ARRAY_BUFFER, buffer)
  glBufferData(GL_ARRAY_BUFFER, 6 * sizeof(float32), positions[0].addr, GL_STATIC_DRAW)

  glEnableVertexAttribArray(0)
  glVertexAttribPointer(0, 2, EGL_FLOAT, false, 2 * sizeof(float32), nil)

  var vertexShader: cstring = """
#version 330 core

layout (location = 0) in vec4 position;

void main() {
  gl_Position = position;
}
  """
  var fragmentShader: cstring = """
#version 330 core

layout (location = 0) out vec4 color;

void main() {
  color = vec4(1.0, 0.0, 0.0, 1.0);
}
  """
  let shader = createShader(vertexShader, fragmentShader)
  glUseProgram(shader)

  while not window.windowShouldClose:
    glClear(GL_COLOR_BUFFER_BIT)

    glDrawArrays(GL_TRIANGLES, 0, 3)

    window.swapBuffers
    glfwPollEvents()

  glDeleteProgram(shader)
  window.destroyWindow
  glfwTerminate()

main()