$(function(){
    var elements = $('.modal-overlay, .modal');
    $('.img_01_show').click(function(){
    // $('#imgclick').click(function(){
        // var id = $(this).val();
        // alert(id);
        elements.addClass('active');
    });
    
    $('.close-modal').click(function(){
        elements.removeClass('active');
    });
    var bar=$('#progress_bar');
    var percentage=parseInt($('#progress_percentage').html());

    function stopProgress(){
    clearInterval(progress);
    }

    var progress= setInterval(function(){
    percentage++;
    if (percentage<=100){
        $('#progress_percentage').html(percentage+'%');
        if (percentage>10) {
        bar.css('width',percentage+'%');
        console.log(percentage);
        }
    }
    else {
        stopProgress()
    }
    },80);

    });

    