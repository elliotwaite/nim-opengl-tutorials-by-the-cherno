import nimgl/opengl

type
  IndexBuffer* = ref object
    rendererId*: uint32
    count*: int32

proc `=destroy`*(ib: var typeof(IndexBuffer()[])) =
  glDeleteBuffers(1, ib.rendererId.addr)

proc newIndexBuffer*(data: var openArray[uint32], count: int32): IndexBuffer =
  result = IndexBuffer(count: count)
  glGenBuffers(1, result.rendererId.addr)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, result.rendererId)
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, count * sizeof(uint32), data.addr, GL_STATIC_DRAW)

proc `bind`*(ib: IndexBuffer) =
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ib.rendererId)

proc unbind*(ib: IndexBuffer) =
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0)