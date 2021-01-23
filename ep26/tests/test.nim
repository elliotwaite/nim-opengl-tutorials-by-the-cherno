import sequtils
import nimgl/imgui

type
  Test* = ref object of RootObj

method onUpdate*(test: Test, deltaTime: float32) = discard
method onRender*(test: Test) = discard
method onImGuiRender*(test: Test) = discard

type
  TestMenu* = ref object of Test
    currentTest*: Test
    tests*: seq[(string, proc: Test)]

method onImGuiRender*(self: TestMenu) =
  for (testName, newTest) in self.tests:
    if igButton(testName):
      self.currentTest = newTest()

proc registerTest*(self: TestMenu, name: string, newTest: proc: Test) =
  echo "Registering test " & name
  self.tests.add((name, newTest))

