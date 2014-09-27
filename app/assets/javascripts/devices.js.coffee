$(document).ready () ->
  $(document).find('.device-animation').each () ->
    container = $(this)
    device = container.find('.device')
    keyframes = []

    last_keyframe = {
      time: 0
      device: 'pc'
      scale: '1'
    }
    container.find('.keyframes > .keyframe').each () ->
      item = $(this)
      keyframe = {
        time: unless item.data('time') == null then item.data('time') else last_keyframe.time + 1000
        device: (item.data('device') or last_keyframe.device)
        scale: (item.data('scale') or last_keyframe.scale)
      }
      keyframes.push keyframe
      last_keyframe = keyframe


    console.log(JSON.stringify(keyframes))
    run_animation(container, device, keyframes)


run_animation = (container, device, keyframes, current = 0) ->
  keyframe = keyframes[current]
  last_time = if current == 0 then 0 else keyframes[current - 1].time
  last_keyframe = keyframes[(current + keyframes.length - 1) % keyframes.length]

  setTimeout(()->
    device.removeClass(device_class(last_keyframe))
    device.addClass(device_class(keyframe))
    run_animation(container, device, keyframes, (current + 1) % keyframes.length)
  , keyframe.time - last_time)


device_class = (keyframe) ->
  "device-#{keyframe.device}"