$(document).on 'mouseenter', '.header-control', () ->
  show_header($(this))

$(document).on 'click', '.header-control', () ->
  show_header($(this))

$(document).on 'mouseleave', '.header-container', () ->
#  unless is_mobile()
#    hide_header($(this))

$(document).mouseup (e) ->
  header = $('header')
  if header.is(e.target) or header.has(e.target).length == 0
    hide_header(header)


$(document).on 'click', '.header-control.active', () ->
  hide_header($(this).closest('header'))

show_header = (control) ->
  return if control.hasClass('active')
  header = control.closest('header')
  content = header.find('#header-content')
  control.addClass('active')
  if small_window() or is_mobile()
    content.show()
  else
    content.css('float', 'left')
    content.css('width', "calc(100% - #{control.outerWidth(true)}px")

hide_header = (header) ->
  control = header.find('.header-control')
  content = header.find('#header-content')

  if small_window() or is_mobile()
    content.hide()
    control.removeClass('active')

  else
    control.removeClass('active')
    content.css('float', 'right')
    content.css('width', 0)

small_window = () ->
  $(window).width() <= 768

is_mobile = ()->
  /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent)