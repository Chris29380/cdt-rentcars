
var tr = []
var data = []
var cars = []
var datacar = []
var theme = "orange"
var imgpath = "https://docs.fivem.net/vehicles/"
var indexpoint

window.addEventListener('message', function(event) {
    if (event.data.type == "openUi") {
						
		data = event.data.data
		title = event.data.title
		currency = event.data.currency
		theme = event.data.theme
		indexpoint = event.data.indexpoint

		$("body").css("display","flex")
		
		loadmenu()
		applytheme()
    }

	if (event.data.type == "closeUi") {
		
		hideUi()
    }
})

function applytheme() {
	if (theme) {
		if (theme == "Blue") {
			$("body .content .title").css("background-color","rgba(0,116,255,0.75)")
			$("body .content .title").css("color","white")
			$("body .content .boxes .box .price").css("color","#0074ff")
		}
		if (theme == "White") {
			$("body .content .title").css("background-color","rgba(255,255,255,0.75)")
			$("body .content .title").css("color","white")
			$("body .content .boxes .box .price").css("color","white")
		}
		if (theme == "Red") {
			$("body .content .title").css("background-color","rgba(255,0,0,0.75)")
			$("body .content .title").css("color","white")
			$("body .content .boxes .box .price").css("color","red")
		}
		if (theme == "Green") {
			$("body .content .title").css("background-color","rgba(2,206,113,0.75)")
			$("body .content .title").css("color","white")
			$("body .content .boxes .box .price").css("color","#02ce71")
		}
	}
}

function loadmenu() {
	if (data) {

		cars = data["cars"]
		htmlCar = ``
		htmlTitle = ``

		htmlTitle = `${title}`
		$("body .content .title").html(htmlTitle)

		if (cars && cars.length > 0 ) {
			for (let carsIndex = 0; carsIndex < cars.length; carsIndex++) {
				const elementCar = cars[carsIndex]
				let name = elementCar.model
				let label = elementCar.label     
				let price = elementCar.price
				imgpath = elementCar.imgPath
				htmlCar = htmlCar + `
				<div class="box" id="box" onclick="checkspawn(dataset.indv)" data-indv=${carsIndex}>
					<div class="boximg" id="boximg">
						<img src="${imgpath}${name}.webp">
					</div>
					<div class="price" id="price">${price} ${currency}</div>
				</div>
				`
			}
			$("body .content .boxes").html(htmlCar)
		} else {
			console.log("no cars in this location")
		}

	} else {
		console.log("no data")
	}
}

function checkspawn(indexveh) {
	if (indexveh && indexveh >=0 ) {
		let datas = {
			indexp : indexpoint,
			indexveh : indexveh,
			datap : data,
			dataveh : cars[indexveh]
		}
		$.post(`https://${GetParentResourceName()}/checkspawnveh`, JSON.stringify({datas}))		
	} else {
		console.log("no indexveh")
	}
}

// functions base

window.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        hideUi()
    }
})

function hideUi() {    
    $("body").css("display", "none")
    $.post(`https://${GetParentResourceName()}/closeUI`, JSON.stringify({}))
}