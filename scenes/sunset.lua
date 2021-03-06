local lume = require('lume')
nodes = require('nodes')

sky =
{tint,
  {0.14, 0.5, 0.8},
  {combine,
    {combine,
      {edge},
      {position,
        {0, 0, 0.5},
        {edge, 0, 1},
      }
    },
  },
}

sun =
{tint,
  {0.15, 0.73, 0.97},
  {position,
    {0, 0, 0, .2},
    {wrap, 1,
      {edge},
    },
  },
}

sea =
{tint,
  {0.58, 0.38, 0.16},
  {edge, 0, 1},
}

cloudLayer =
{clip,
  -- limit to horizontal stripe
  {position,
    {0, -.8, .5},
    {edge, 0, 1},
  },
  {position,
    {0, 0.4, 0},
    {edge, 0, 1},
  },
  -- noise as clouds
  {combine,
    {tint,
      {0.2, 0.38, 0.86},
      {simplex, 0.1, 1},
    },
    {tint,
      {0.1, 0.53, 0.65},
      {position,
        {0, -0.12, 0, 1, 1},
        {simplex, 0.1, 1},
      },
    }
  }
}

clouds =
{position,
  {0, 0.2, 0, .7, .15},
  cloudLayer,
}

mirror_sun =
{position,
  {0, .05, 0, 1, -1},
  sun,
}

reflection =
{tint,
  {.10, .78, .35},
  {combine,
    {clip,
      {position,
        {0, 0, 0, 1, 5},
        mirror_sun,
      },
      sea,
    },
    {position,
      {0, 50, 0, 1, .06},
      mirror_sun,
    },
  },
}

local scene = {
  combine,
  clouds,
  reflection,
  sea,
  sun,
  sky,
}

function gaussian (mean, variance)
    return  math.sqrt(-2 * variance * math.log(math.random())) *
            math.cos(math.random()) + mean
end

function scene.tick(scene, t)
  local hour = lume.remap(love.mouse.getX(), 0, love.graphics.getWidth(), 15, 23)
  clouds[2][1] = t / 100 -- + readTilt()
  --16 + ((t/6 + 3.5) % 8)

  -- sun location
  sun[3][2][1] = lume.remap(hour, 16, 21, -.1, -.3)
  sun[3][2][2] = lume.remap(hour, 16, 20.5, .51, 0)
  -- sun shade
  sun[2][1] = lume.remap(gaussian(hour, .3), 16, 21, .15, .05)
  sun[2][2] = .95
  sun[2][3] = lume.remap(gaussian(hour, .3), 16, 21, .97, .4)
  -- reflection shade
  reflection[2][1] = lume.remap(gaussian(hour, .1), 16, 21, .15, .05)
  reflection[2][2] = .95
  reflection[2][3] = lume.remap(hour, 16, 21, .97, .4)
  -- cloud shade
  clouds[3][4][2][2][1] = lume.remap(hour, 16, 21, 0.2, 0.05)
  clouds[3][4][2][2][2] = lume.remap(hour, 16, 21, .38, .7)
  clouds[3][4][2][2][3] = lume.remap(hour, 16, 20, .96, .3)
  clouds[3][4][3][2][1] = lume.remap(hour, 16, 21, 0.1, 0.02)
  clouds[3][4][3][2][2] = lume.remap(hour, 16, 21, .53, .6)
  clouds[3][4][3][2][3] = lume.remap(hour, 16, 20, .65, .4)
  -- sky shade
  sky[2][1] = lume.remap(hour, 14, 21, .17, .07)
  sky[2][2] = lume.remap(hour, 14, 21, .3, .9)
  sky[2][3] = lume.remap(hour, 14, 23, .97, .02, 'clamp')
  -- sea shade
  sea[2][1] = lume.remap(hour, 16, 21, .6, .38, 'clamp')
  sea[2][2] = lume.remap(hour, 16, 19, .6, .3)
  sea[2][3] = lume.remap(hour, 16, 22, .37, .08)
end

return scene
