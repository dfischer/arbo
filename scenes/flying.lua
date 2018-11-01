local lume = require('lume')
require('nodes')

local palette = require('scenes/edg32')

local earthZoom = 35

local C = {
  sky_blue = {0.55, 1.00, 0.43},
}

local cloudShape = {position, {0, .303,  0, .124/3, .065/3},  {simplex, -.2}}

local scene =
{
  position,
  {0, 0, .05, .68},
  {
    position,
    {0, -earthZoom, 0.04, earthZoom},
    {
      wrap,
      {
        combine,
        --clouds
        {tint, {0.60, 0.21, 0.63}, {
          clip,
          cloudShape,
          {position, {0.01, .02,  0, .124/3, .045/3},  {simplex, -.2}},
          {position, {0, -.2, .5}, {edge}},
          {position, {0, .06, 0}, {edge}}
        }},
        {tint, {0.00, 0.00, 1.00}, {clip, cloudShape, {position, {0, -.15, .5}, {edge}}, {position, {0, .06, 0}, {edge}},}},

        --ground
        {tint, {0.30, 0.52, 0.54}, {clip, {position, {0,  0.00, 0, .05, .03}, {simplex, .15}}, {edge}}},
        --{tint, {0.36, 0.38, 0.39}, {clip, {position, {0, -0.03, 0, .05, .03}, {simplex, .2}}, {edge}}},
        {tint, {0.58, 0.77, 0.30}, {position, {0,0,0}, {edge}}},
        -- sky
        {tint, C.sky_blue, {position, {0,-5,.5}, {edge}}},
      },
    },
    --{tint, {0.36, 0.38, 0.39}, {position, {0,0,29/count}, splat}},
  },
  --update = function(scene, dt, t)
  --  earthZoom = lume.remap(love.mouse.getX(), 0, love.graphics.getWidth(), .4, 50)
  --  scene[3][2][2][2] = -earthZoom
  --  scene[3][2][2][4] = earthZoom
  --end
}
--[[
    {tint, {0.58, 0.77, 0.30}, {position, {0,0,32/count}, splat}}, -- sea blue
    {tint, {0.51, 0.43, 0.17}, {position, {0,0,31/count}, splat}}, -- shade tree green
    {tint, {0.42, 0.42, 0.25}, {position, {0,0,30/count}, splat}},
    {tint, {0.36, 0.38, 0.39}, {position, {0,0,29/count}, splat}},
    {tint, {0.30, 0.52, 0.54}, {position, {0,0,28/count}, splat}}, -- light green
    {tint, {0.14, 0.99, 0.69}, {position, {0,0,27/count}, splat}}, -- sun yellow
    {tint, {0.10, 0.99, 0.60}, {position, {0,0,26/count}, splat}},
    {tint, {0.07, 0.93, 0.55}, {position, {0,0,25/count}, splat}},
    {tint, {0.99, 0.76, 0.56}, {position, {0,0,24/count}, splat}}, -- red
    {tint, {0.98, 0.62, 0.39}, {position, {0,0,23/count}, splat}}, -- sunset
    {tint, {0.93, 0.23, 0.20}, {position, {0,0,22/count}, splat}}, -- dark brown
    {tint, {0.01, 0.34, 0.34}, {position, {0,0,21/count}, splat}},
    {tint, {0.05, 0.42, 0.52}, {position, {0,0,20/count}, splat}},
    {tint, {0.08, 0.68, 0.67}, {position, {0,0,19/count}, splat}}, -- light desaturated brown
    {tint, {0.11, 0.60, 0.79}, {position, {0,0,18/count}, splat}}, -- light brown
    {tint, {0.06, 0.65, 0.55}, {position, {0,0,17/count}, splat}}, -- brown
    {tint, {0.03, 0.60, 0.46}, {position, {0,0,16/count}, splat}}, -- saturated brown
    {tint, {0.05, 0.42, 0.59}, {position, {0,0,15/count}, splat}},
    {tint, {0.07, 0.64, 0.75}, {position, {0,0,14/count}, splat}},
    {tint, {0.99, 0.88, 0.71}, {position, {0,0,13/count}, splat}}, -- pink
    {tint, {0.91, 0.41, 0.51}, {position, {0,0,12/count}, splat}},
    {tint, {0.82, 0.32, 0.32}, {position, {0,0,11/count}, splat}}, -- purple
    {tint, {0.96, 1.00, 0.50}, {position, {0,0,10/count}, splat}}, -- magenta
    {tint, {0.71, 0.30, 0.11}, {position, {0,0,9/count}, splat}}, -- dark navy
    {tint, {0.64, 0.28, 0.21}, {position, {0,0,8/count}, splat}},
    {tint, {0.63, 0.28, 0.31}, {position, {0,0,7/count}, splat}}, -- desaturated blue
    {tint, {0.61, 0.20, 0.44}, {position, {0,0,6/count}, splat}},
    {tint, {0.60, 0.21, 0.63}, {position, {0,0,5/count}, splat}}, -- ice gray
    {tint, {0.60, 0.29, 0.81}, {position, {0,0,4/count}, splat}},
    {tint, {0.00, 0.00, 1.00}, {position, {0,0,3/count}, splat}}, -- pure white
    {tint, {0.51, 0.91, 0.57}, {position, {0,0,2/count}, splat}}, -- aqua
    {tint, {0.55, 1.00, 0.43}, {position, {0,0,1/count}, splat}}, -- sky blue
--]]
return scene
