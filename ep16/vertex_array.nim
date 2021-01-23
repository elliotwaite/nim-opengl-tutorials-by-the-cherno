import nimgl/opengl
import vertex_buffer, vertex_buffer_layout

type
  VertexArray* = ref object
    rendererId: uint32

proc `=destroy`*(va: var typeof(VertexArray()[])) =
  glDeleteVertexArrays(1, va.rendererId.addr)

proc newVertexArray*: VertexArray =
  result = VertexArray()
  glGenVertexArrays(1, result.rendererId.addr)

proc `bind`*(va: VertexArray) =
  glBindVertexArray(va.rendererId)

proc unbind*(va: VertexArray) =
  glBindVertexArray(0)

proc addBuffer*(va: VertexArray, vb: VertexBuffer, layout: VertexBufferLayout) =
  va.`bind`
  vb.`bind`
  var offset: ByteAddress
  for i, element in layout.elements:
    glEnableVertexAttribArray(i.uint32)
    glVertexAttribPointer(i.uint32, element.count, element.`type`, element.normalized,
                          layout.stride, cast[pointer](offset))
    offset += element.count * element.getSizeOfType