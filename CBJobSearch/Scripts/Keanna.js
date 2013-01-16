$(function () {

    var $textBox1 = $('#TextBox1');
    var $textBox2 = $('#TextBox2');

    $textBox1.addClass('location');
    $textBox2.addClass('keywords');

    applyHiddenText($textBox1);
    applyHiddenText($textBox2);

    var $row = $('#row');



});

function applyHiddenText($input) {
    $input.keyup(function () {
        var text = $input.val();
        if (text.length > 0) {
            $input.removeClass('form-inputOn');
            $input.addClass('helperTextOff');
        } else {
            $input.removeClass('helperTextOff');
            $input.addClass('form-inputOn');
        }
    });
}