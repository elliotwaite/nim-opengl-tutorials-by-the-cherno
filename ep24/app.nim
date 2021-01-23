import os, sequtils, strutils
import nimgl/[glfw, opengl]
import nimgl/imgui, nimgl/imgui/[impl_opengl, impl_glfw]
import glm/[mat, mat_transform, vec]
import index_buffer, renderer, shader, texture, vertex_array, vertex_buffer, vertex_buffer_layout
import tests/[test, test_clear_color]

proc keyProc(window: GLFWWindow, key, scancode, action, mods: int32) {.cdecl.} =
  if key == GLFWKey.ESCAPE and action == GLFWPress:
    window.setWindowShouldClose(true)

proc main =
  assert glfwInit()

  glfwWindowHint(GLFWContextVersionMajor, 3)
  glfwWindowHint(GLFWContextVersionMinor, 3)
  glfwWindowHint(GLFWOpenglForwardCompat, GLFW_TRUE)
  glfwWindowHint(GLFWOpenglProfile, GLFW_OPENGL_CORE_PROFILE)

  let window: GLFWWindow = glfwCreateWindow(960, 540, "Hello World")
  if window == nil:
    glfwTerminate()
    quit(QuitFailure)

  discard window.setKeyCallback(keyProc)
  window.makeContextCurrent

  assert glInit()

  echo "OpenGL version: ", cast[cstring](glGetString(GL_VERSION))
  echo "OpenGL renderer: ", cast[cstring](glGetString(GL_RENDERER))

  glfwSwapInterval(1)

  block:
    glEnable(GL_BLEND)
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)

    let renderer = Renderer()

    let context = igCreateContext()
    doAssert igGlfwInitForOpenGL(window, true)
    igStyleColorsDark()

    let test = newTestClearColor()

    while not window.windowShouldClose:
      renderer.clear

      test.onUpdate(0.0f)
      test.onRender

      igOpenGL3NewFrame()
      igGlfwNewFrame()
      igNewFrame()
      test.onImGuiRender
      igRender()
      igOpenGL3RenderDrawData(igGetDrawData())

      checkErrors()
      window.swapBuffers
      glfwPollEvents()

    igOpenGL3Shutdown()
    igGlfwShutdown()
    context.igDestroyContext

  window.destroyWindow
  glfwTerminate()

main()