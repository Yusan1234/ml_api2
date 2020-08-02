$(function(){
    var elements = $('.modal-overlay, .modal');
    
    $('#imgclick').click(function(){
        var id = $(this).val();
        alert(id);
        elements.addClass('active');
    });
    
    $('.close-modal').click(function(){
        elements.removeClass('active');
    });
    });