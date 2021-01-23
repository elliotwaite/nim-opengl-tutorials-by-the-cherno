import nimgl/[glfw, opengl]

proc checkErrors* =
  var error = glGetError()
  if error != GL_NO_ERROR:
    while error != GL_NO_ERROR:
      case error:
        of GL_INVALID_ENUM:
          echo "OpenGl Error: GL_INVALID_ENUM. An unacceptable value is specified for an enumerated argument. The offending command is ignored and has no other side effect than to set the error flag."
        of GL_INVALID_VALUE:
          echo "OpenGl Error: GL_INVALID_VALUE. A numeric argument is out of range. The offending command is ignored and has no other side effect than to set the error flag."
        of GL_INVALID_OPERATION:
          echo "OpenGl Error: GL_INVALID_OPERATION. The specified operation is not allowed in the current state. The offending command is ignored and has no other side effect than to set the error flag."
        of GL_INVALID_FRAMEBUFFER_OPERATION:
          echo "OpenGl Error: GL_INVALID_FRAMEBUFFER_OPERATION. The framebuffer object is not complete. The offending command is ignored and has no other side effect than to set the error flag."
        of GL_OUT_OF_MEMORY:
          echo "OpenGl Error: GL_OUT_OF_MEMORY. There is not enough memory left to execute the command. The state of the GL is undefined, except for the state of the error flags, after this error is recorded."
        of GL_STACK_UNDERFLOW:
          echo "OpenGl Error: GL_STACK_UNDERFLOW. An attempt has been made to perform an operation that would cause an internal stack to underflow."
        of GL_STACK_OVERFLOW:
          echo "OpenGl Error: GL_STACK_OVERFLOW. An attempt has been made to perform an operation that would cause an internal stack to overflow."
        else:
          echo "OpenGl Error: An unknown error has occured."

      error = glGetError()

    writeStackTrace()
    quit(QuitFailure)