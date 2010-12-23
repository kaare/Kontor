jQuery(document).ready(function(){
	Grider = {
		defaults : {
			initCalc: true,
			addRow: true,
			addRowWithTab: true,
			delRow: true,
			decimals: 2,
			addRowText: '<caption><a href="#">Add Row</a></caption>',
			delRowText: '<td><a href="#" class="delete">delete</a></td>',
			countRow: false,
			countRowCol: 0,
			countRowText: '#',
			countRowAdd: false,
			addedRow: false
		}
	}

	$('#table1').grider({countRow: true, countRowAdd: true});
	$(this).hide();
	$('#submit1').attr('disabled', false)

});
