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
			addedRow: false,
			rowFunc: rowDefaults
		}
	}
	$('#table1').grider({countRow: true, countRowAdd: true});
	$('#submit1').attr('disabled', false)
});

function rowDefaults(tr) {
	var dt = $(tr).find('td .date');
	dt.val('2010-12-24');
	alert(tr.text());
}
	