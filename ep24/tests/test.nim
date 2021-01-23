type
  Test* = ref object of RootObj

method onUpdate*(test: Test, deltaTime: float32) = discard
method onRender*(test: Test) = discard
method onImGuiRender*(test: Test) = discard