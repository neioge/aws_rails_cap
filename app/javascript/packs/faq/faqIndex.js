// オンロードはページとすべての画像などのリソース類を読み込んでから処理を実行するときに利用します。
window.onload = function () {
    // ＄マークにあまり意味は無いらしい。jQueryでは使うとのことだが。
    // 取得するのはolのidで。実戦では<ol id='faqs'>だろう。それにchildrenでリストを全て取得できる。アイテムズなので、配列だ。
    var $getFaqItems = document.getElementById("faqs").children;
    // var $getFaqItems = document.getElementById("answers").children;
    
    // 
    for (var $i = 0; $i < $getFaqItems.length; $i++) {
        $getFaqItems[$i].onclick =
            function () {
                drawFAQ(this.innerHTML, $i);
            };
    }
}

// 関数名＝drawFAQ 引数名＝question 変数名＝question_info id=question 
function drawFAQ($activeQuestion, activeNo) {
    var $question_info = document.getElementById("activeQuestion");
    
    // question.innerHTML=question
    var $answer = document.getElementById("answer-"+ activeNo );
    console.log($answer);
    $question_info.innerHTML = $activeQuestion;
}