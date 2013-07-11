# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#allocations').dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap",
    "fnDrawCallback": (oSettings) ->
      if oSettings.bSorted || oSettings.bFiltered
        for i in [0..(oSettings.aiDisplay.length)]
          $('td:eq(0)', oSettings.aoData[ oSettings.aiDisplay[i] ].nTr ).html(i+1)

    "aoColumnDefs": [
        { "bSortable": false, "aTargets": [0] }
      ],
    "aaSorting": [[ 1, 'desc' ]]
  });
