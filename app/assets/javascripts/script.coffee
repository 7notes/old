if $("div[data-page='main']").length == 1
	angular.module "main", []
	.controller "main", ($scope, $http)->
		

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

if $("div[data-page='sign_up']").length == 1
	angular.module "sign_up", []
	.controller "form", ($scope, $http)->
		$scope.form = {
			username: '',
			email: '',
			password: '',
			first_name: '',
			last_name: '',
			gender: '',
			language: navigator.language.substr(0, 2)
		}
		success = (res)->
			res = res.data
			console.log res
		$scope.submit = ->
			$http({
				method: 'post',
				url: '/account/sign_up',
				data: $scope.form,
				headers: {
					'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
				}
			}).then((res)->
				res = res.data
				console.log res
			)
if $("div[data-page='sign_in']").length == 1
	angular.module "sign_in", []
	.controller "form", ($scope, $http)->
		$scope.form = {
			username: '',
			password: '',
		}
		success = (res)->
			res = res.data
			console.log res
		$scope.submit = ->
			$http({
				method: 'post',
				url: '/account/sign_in',
				data: $scope.form,
				headers: {
					'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
				}
			}).then((res)->
				res = res.data
				console.log res
			)
