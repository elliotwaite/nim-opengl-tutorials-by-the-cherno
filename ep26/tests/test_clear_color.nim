import nimgl/[imgui, opengl]
import test

type
  TestClearColor* = ref object of Test
    clearColor*: array[4, float32]

proc newTestClearColor*(): TestClearColor =
  result = TestClearColor(clearColor: [0.2f, 0.3, 0.8, 1.0])

method onRender*(self: TestClearColor) =
  glClearColor(self.clearColor[0], self.clearColor[1], self.clearColor[2], self.clearColor[3])
  glClear(GL_COLOR_BUFFER_BIT)

method onImGuiRender*(self: TestClearColor) =
  igColorEdit4("Clear color", self.clearColor)