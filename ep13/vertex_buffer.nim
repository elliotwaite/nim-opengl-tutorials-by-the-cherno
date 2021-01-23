import nimgl/opengl

type
  VertexBuffer* = ref object
    rendererId*: uint32

proc `=destroy`*(vb: var typeof(VertexBuffer()[])) =
  glDeleteBuffers(1, vb.rendererId.addr)

proc newVertexBuffer*(data: var openArray[float32], size: int): VertexBuffer =
  result = VertexBuffer()
  glGenBuffers(1, result.rendererId.addr)
  glBindBuffer(GL_ARRAY_BUFFER, result.rendererId)
  glBufferData(GL_ARRAY_BUFFER, size, data[0].addr, GL_STATIC_DRAW)

proc `bind`*(vb: VertexBuffer) =
  glBindBuffer(GL_ARRAY_BUFFER, vb.rendererId)

proc unbind*(vb: VertexBuffer) =
  glBindBuffer(GL_ARRAY_BUFFER, 0)