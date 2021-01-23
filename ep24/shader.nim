import strutils, tables
import nimgl/opengl, glm/mat

type
  Shader* = ref object
    filepath*: string
    rendererId*: uint32
    uniformLocationCache: Table[string, int32]

  ShaderProgramSource = object
    vertexSource: string
    fragmentSource: string

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

proc `=destroy`*(shader: var typeof(Shader()[])) =
  glDeleteProgram(shader.rendererId)

proc newShader*(filepath: string): Shader =
  let shaderProgramSource = parseShader(filepath)
  let rendererId = createShader(shaderProgramSource)
  Shader(filepath: filepath, rendererId: rendererId)

proc `bind`*(shader: Shader) =
  glUseProgram(shader.rendererId)

proc unbind*(shader: Shader) =
  glUseProgram(0)

proc getUniformLocation(shader: Shader, name: string): int32 =
  if name in shader.uniformLocationCache:
    return shader.uniformLocationCache[name]

  result = glGetUniformLocation(shader.rendererId, name)
  if result == -1:
    echo "Warning: uniform " & name & " doesn't exist!"

  shader.uniformLocationCache[name] = result

proc setUniform1i*(shader: Shader, name: string, value: int32) =
  glUniform1i(shader.getUniformLocation(name), value)

proc setUniform1f*(shader: Shader, name: string, value: float) =
  glUniform1f(shader.getUniformLocation(name), value)

proc setUniform4f*(shader: Shader, name: string, v0, v1, v2, v3: float) =
  glUniform4f(shader.getUniformLocation(name), v0, v1, v2, v3)

proc setUniformMat4f*(shader: Shader, name: string, matrix: var Mat) =
  glUniformMatrix4fv(shader.getUniformLocation(name), 1, false, matrix.caddr)

