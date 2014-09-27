$(document).on 'mouseenter', '.header-control', () ->
  control = $(this)
  header = $(this).closest('header')
  content = header.find('#header-content')
  content.css('float', 'left')
  control.addClass('active')
  content.css('width', "calc(100% - #{control.outerWidth(true)}px")

$(document).on 'mouseleave', '.header-container', () ->
  header = $(this)
  control = header.find('.header-control')
  content = header.find('#header-content')
  control.removeClass('active')
  content.css('float', 'right')
  content.css('width', 0)
