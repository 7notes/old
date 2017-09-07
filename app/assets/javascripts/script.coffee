$(document).ready ->
	header = $('nav.navbar')
	logo = header.find('a.navbar-brand img')
	logo.mouseover ->
		logo.animate({
			width: '60px'
		}, 250)
	logo.mouseout ->
		logo.animate({
			width: '50px'
		}, 250)
	searchForm = header.find('form')
	searchForm.submit ->
		console.log searchForm.find('input').val()
