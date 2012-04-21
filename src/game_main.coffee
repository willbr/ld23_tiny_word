notes = """
tiny world rts

victory: destruction of enemy base

aim for games < 10min

units move quickly

units auto gen 1 every 15 seconds
max 15 people
start with 1 hero; no respawn

limited buildings
no repair of buildings
"""

start = new Date
start = start.toISOString()

console.log "starting: #{start}"

wait = (milliseconds, func) -> setTimeout func, milliseconds

canvas = document.getElementById "mainCanvas"

if canvas.getContext
  ctx = canvas.getContext '2d'

draw = ->
  ctx.fillStyle = 'rgb(255,0,0)'
  ctx.fillRect 10, 10, 55, 50

  ctx.fillStyle = "rgba(0,0,200, 0.5)"
  ctx.fillRect 30, 30, 55, 50

relMouseCoords = (e) ->
  if e.pageX or e.pageY
    x = e.pageX
    y = e.pageY
  else
    x = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft
    y = e.clientY + document.body.scrollTop + document.documentElement.scrollTop
  x -= @offsetLeft
  y -= @offsetTop
  return {x, y}

HTMLCanvasElement.prototype.relMouseCoords = relMouseCoords

mouseDown = (e) ->
  coords = canvas.relMouseCoords e
  x = coords.x
  y = coords.y
  ctx.fillRect x, y, 55, 50

keyDown = (e) ->
  e ?= window.event

keyUp = (e) ->
  e?= window.event

document.onkeydown = keyDown
document.onkeyup = keyUp
canvas.onmousedown = mouseDown

draw()
