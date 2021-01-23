import os
import nimgl/[imgui, opengl]
import glm/[mat, mat_transform, vec]
import ../index_buffer, ../renderer, ../shader, ../texture, ../vertex_array,
  ../vertex_buffer, ../vertex_buffer_layout
import test

type
  TestTexture2D = ref object of Test
    vao: VertexArray
    vertexBuffer: VertexBuffer
    indexBuffer: IndexBuffer
    shader: Shader
    texture: Texture
    proj, view: Mat4[float32]
    translationA, translationB: Vec3[float32]

proc newTestTexture2D*(): TestTexture2D =
  result = TestTexture2D(
    proj: ortho(0.0f, 960.0, 0.0, 540.0, -1.0, 1.0),
    view: translate(mat4(1.0f), vec3(-100.0f, 0.0, 0.0)),
    translationA: vec3(200.0f, 200.0, 0.0),
    translationB: vec3(400.0f, 200.0, 0.0),
  )

  var positions = [
    100.0f, 100.0, 0.0, 0.0,
    200.0, 100.0, 1.0, 0.0,
    200.0, 200.0, 1.0, 1.0,
    100.0, 200.0, 0.0, 1.0,
  ]

  var indices = [
    0u32, 1, 2,
    2, 3, 0,
  ]

  glEnable(GL_BLEND)
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)

  result.vao = newVertexArray()

  result.vertexBuffer = newVertexBuffer(positions, 4 * 4 * sizeof(float32))
  let layout = VertexBufferLayout()
  layout.add(EGL_FLOAT, 2)
  layout.add(EGL_FLOAT, 2)
  result.vao.addBuffer(result.vertexBuffer, layout)

  result.indexBuffer = newIndexBuffer(indices, 6)

  result.shader = newShader(currentSourcePath.parentDir / "../basic.shader")
  result.shader.`bind`
  # result.shader.setUniform4f("u_Color", 0.8, 0.3, 0.8, 1.0)

  result.texture = newTexture(currentSourcePath.parentDir /
                              "../../res/textures/cherno_logo.png")
  result.shader.setUniform1i("u_Texture", 0)

method onRender*(self: TestTexture2D) =
  glClearColor(0, 0, 0, 1)
  glClear(GL_COLOR_BUFFER_BIT)

  let renderer = Renderer()

  self.texture.`bind`

  block:
    let model = translate(mat4(1.0f), self.translationA)
    var mvp = self.proj * self.view * model
    self.shader.`bind`
    self.shader.setUniformMat4f("u_MVP", mvp)
    renderer.draw(self.vao, self.indexBuffer, self.shader)

  block:
    let model = translate(mat4(1.0f), self.translationB)
    var mvp = self.proj * self.view * model
    self.shader.`bind`
    self.shader.setUniformMat4f("u_MVP", mvp)
    renderer.draw(self.vao, self.indexBuffer, self.shader)

method onImGuiRender*(self: TestTexture2D) =
  igSliderFloat3("Translation A", self.translationA.arr, 0.0f, 960.0f)
  igSliderFloat3("Translation B", self.translationB.arr, 0.0f, 960.0f)
  igText("Application average %.3f ms/frame (%.1f FPS)", 1000.0f / igGetIO().framerate, igGetIO().framerate)
