import os, sequtils, strutils
import nimgl/[glfw, opengl]
import nimgl/imgui, nimgl/imgui/[impl_opengl, impl_glfw]
import glm/[mat, mat_transform, vec]
import index_buffer, renderer, shader, texture, vertex_array, vertex_buffer, vertex_buffer_layout

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
    var positions = [
      -50.0f, -50.0, 0.0, 0.0,
      50.0, -50.0, 1.0, 0.0,
      50.0, 50.0, 1.0, 1.0,
      -50.0, 50.0, 0.0, 1.0,
    ]

    var indices = [
      0u32, 1, 2,
      2, 3, 0,
    ]

    glEnable(GL_BLEND)
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)

    let va = newVertexArray()
    let vb = newVertexBuffer(positions, 4 * 4 * sizeof(float32))

    let layout = VertexBufferLayout()
    layout.add(EGL_FLOAT, 2)
    layout.add(EGL_FLOAT, 2)
    va.addBuffer(vb, layout)

    let ib = newIndexBuffer(indices, 6)

    let proj = ortho(0.0f, 960.0, 0.0, 540.0, -1.0, 1.0)
    let view = translate(mat4(1.0f), vec3(0.0f, 0.0, 0.0))

    let shader = newShader(currentSourcePath.parentDir / "basic.shader")
    shader.`bind`
    # shader.setUniform4f("u_Color", 0.8, 0.3, 0.8, 1.0)

    let texture = newTexture(currentSourcePath.parentDir / "../res/textures/cherno_logo.png")
    texture.`bind`
    shader.setUniform1i("u_Texture", 0)

    va.unbind
    vb.unbind
    ib.unbind
    shader.unbind

    let renderer = Renderer()

    let context = igCreateContext()
    doAssert igGlfwInitForOpenGL(window, true)
    igStyleColorsDark()

    var show_demo: bool = true
    var somefloat: float32 = 0.0f
    var counter: int32 = 0

    var translation = vec3(200.0f, 200.0, 0.0)

    var r = 0.0f
    var increment = 0.05f

    while not window.windowShouldClose:
      renderer.clear

      igOpenGL3NewFrame()
      igGlfwNewFrame()
      igNewFrame()

      let model = translate(mat4(1.0f), translation)
      var mvp = proj * view * model

      shader.`bind`
      # shader.setUniform4f("u_Color", r, 0.3, 0.8, 1.0)
      shader.setUniformMat4f("u_MVP", mvp)

      renderer.draw(va, ib, shader)

      if r > 1.0:
        increment = -0.05
      elif r < 0:
        increment = 0.05

      r += increment

      igSliderFloat3("Translation", translation.arr, 0.0f, 960.0f)
      igText("Application average %.3f ms/frame (%.1f FPS)", 1000.0f / igGetIO().framerate, igGetIO().framerate)

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