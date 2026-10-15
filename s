<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>古文単語クイズ</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Zen+Old+Mincho:wght@600;900&family=Noto+Sans+JP:wght@400;500;700&display=swap">
<style>
:root{--bg:#f3f5f6;--fg:#1c2a38;--mute:#5d6d7c;--line:#d3dbe1;--card:#fff;--ai:#1f3a5f;--aifg:#fff;--ok:#2d7a5c;--okbg:#e0f1e9;--ng:#b0413a;--ngbg:#f7e3e1;
box-sizing:border-box;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}
@media (prefers-color-scheme:dark){:root:not([data-theme="light"]){--bg:#10171e;--fg:#e4eaef;--mute:#93a1ae;--line:#2b3946;--card:#18222c;--ai:#8fb4e3;--aifg:#10171e;--ok:#6fcba5;--okbg:#17342a;--ng:#ef8c84;--ngbg:#3a1f1d}}
:root[data-theme="dark"]{--bg:#10171e;--fg:#e4eaef;--mute:#93a1ae;--line:#2b3946;--card:#18222c;--ai:#8fb4e3;--aifg:#10171e;--ok:#6fcba5;--okbg:#17342a;--ng:#ef8c84;--ngbg:#3a1f1d}
html{scroll-padding-top:env(safe-area-inset-top,0px)}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--fg);font-family:"Noto Sans JP","Hiragino Sans","Yu Gothic",sans-serif;line-height:1.7}
main{max-width:560px;margin:0 auto;padding:20px 16px 48px}
h1{font-family:"Zen Old Mincho","Hiragino Mincho ProN","Yu Mincho",serif;font-weight:900;font-size:28px;margin:8px 0 4px}
h2{font-size:15px;margin:28px 0 8px}
p{margin:0 0 8px}
.mute{color:var(--mute);font-size:14px}
.card{background:var(--card);border:1px solid var(--line);border-radius:12px;padding:16px}
.bar{display:flex;height:14px;border-radius:7px;overflow:hidden;background:var(--line);margin:10px 0 6px}
.bar i{display:block;height:100%}
.legend{display:flex;justify-content:space-between;font-size:12px;color:var(--mute)}
button{font:inherit;cursor:pointer;border-radius:10px;border:1px solid var(--line);background:var(--card);color:var(--fg);padding:12px 14px}
button:focus-visible,textarea:focus-visible{outline:3px solid var(--ai);outline-offset:2px}
.primary{background:var(--ai);color:var(--aifg);border-color:var(--ai);font-weight:700;width:100%;padding:14px;font-size:17px}
.row{display:flex;gap:8px;margin-top:8px}
.row button{flex:1}
.word{font-family:"Zen Old Mincho","Hiragino Mincho ProN","Yu Mincho",serif;font-weight:900;font-size:44px;text-align:center;margin:20px 0 4px;word-break:keep-all}
.top{display:flex;justify-content:space-between;font-size:14px;color:var(--mute)}
.opts{display:grid;gap:10px;margin-top:16px}
.opt{text-align:left;padding:14px;line-height:1.5}
.opt.ok{background:var(--okbg);border-color:var(--ok);color:var(--ok);font-weight:700}
.opt.ng{background:var(--ngbg);border-color:var(--ng);color:var(--ng)}
.opt:disabled{cursor:default;opacity:1}
.fb{margin-top:14px;font-weight:700}
textarea{width:100%;min-height:120px;font:inherit;font-size:14px;border:1px solid var(--line);border-radius:10px;background:var(--card);color:var(--fg);padding:10px}
.list{margin:8px 0 0;padding:0;list-style:none}
.list li{display:flex;justify-content:space-between;gap:12px;padding:8px 0;border-bottom:1px solid var(--line)}
.list b{font-family:"Zen Old Mincho",serif;white-space:nowrap}
.big{font-family:"Zen Old Mincho",serif;font-size:40px;font-weight:900;text-align:center;margin:12px 0}
</style>
</head>
<body>
<main id="app"></main>
<script>
var SAMPLE=[["あはれなり","しみじみとした情趣がある"],["をかし","趣がある・かわいらしい"],["いと","たいそう・とても"],["やがて","すぐに・そのまま"],["ありがたし","めったにない・珍しい"],["うつくし","かわいらしい"],["かなし","いとしい・かわいい"],["つれづれなり","することがなくて退屈だ"],["いみじ","程度がはなはだしい・すばらしい"],["あさまし","驚きあきれる"],["めでたし","すばらしい・立派だ"],["おどろく","はっと気づく・目が覚める"],["ゆかし","見たい・知りたい・聞きたい"],["あやし","不思議だ・怪しい"],["いらふ","返事をする"],["かしこし","恐れ多い・すぐれている"],["けしき","様子・機嫌"],["さらなり","言うまでもない"],["つとめて","早朝・翌朝"],["ののしる","大声で騒ぐ・評判になる"],["おぼゆ","思われる・似ている"],["ながむ","ぼんやり物思いにふける"],["やさし","恥ずかしい・優美だ"],["わろし","よくない"],["らうたし","かわいい・いじらしい"],["あてなり","高貴だ・上品だ"],["いたづらなり","無駄だ・役に立たない"],["すさまじ","興ざめだ"],["ねんごろなり","心がこもっている・親切だ"],["なでふ","どういう・どうして"]];
var KEY="kobun_quiz_v1",words=[],S=null,app=document.getElementById("app");
var COLORS=["#b0413a","#c9803a","#c8b23a","#5fa07f","#2d7a5c"];
function load(){try{var s=localStorage.getItem(KEY);if(s){words=JSON.parse(s);if(words.length)return}}catch(e){}words=SAMPLE.map(function(x){return{w:x[0],m:x[1],b:1}})}
function save(){try{localStorage.setItem(KEY,JSON.stringify(words))}catch(e){}}
function esc(t){return String(t).replace(/[&<>"]/g,function(c){return{"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;"}[c]})}
function shuffle(a){a=a.slice();for(var i=a.length-1;i>0;i--){var j=Math.floor(Math.random()*(i+1)),t=a[i];a[i]=a[j];a[j]=t}return a}
function counts(){var c=[0,0,0,0,0];words.forEach(function(x){c[x.b-1]++});return c}
function home(msg){
  var c=counts(),n=words.length;
  var bar=c.map(function(v,i){return'<i style="width:'+(v/n*100)+'%;background:'+COLORS[i]+'"></i>'}).join("");
  app.innerHTML='<h1>古文単語クイズ</h1><p class="mute">間違えた単語ほど、たくさん出ます。</p>'
  +'<div class="card" style="margin-top:16px"><div><b>'+n+'語</b> 中 <b>'+(c[3]+c[4])+'語</b> を覚えました</div><div class="bar">'+bar+'</div>'
  +'<div class="legend"><span>まだ（'+c[0]+'）</span><span>'+(c[1]+c[2])+'語 練習中</span><span>覚えた（'+(c[3]+c[4])+'）</span></div></div>'
  +'<div style="margin-top:16px"><button class="primary" id="go">10問はじめる</button></div>'
  +'<h2>単語を入れ替える・追加する</h2><p class="mute">1行に1語、「単語,意味」の形で貼り付けます（タブ区切りもOK）。</p>'
  +'<textarea id="ta" placeholder="あはれなり,しみじみとした情趣がある"></textarea>'
  +'<div class="row"><button id="add">追加する</button><button id="rep">全部入れ替える</button></div>'
  +'<p class="mute" id="msg" style="margin-top:8px">'+(msg||"")+'</p>'
  +'<h2>練習中の単語</h2><ul class="list">'+words.filter(function(x){return x.b<=2}).slice(0,12).map(function(x){return'<li><b>'+esc(x.w)+'</b><span class="mute">'+esc(x.m)+'</span></li>'}).join("")+'</ul>'
  +'<div class="row" style="margin-top:24px"><button id="reset">進み具合をリセット</button></div>';
  document.getElementById("go").onclick=start;
  document.getElementById("add").onclick=function(){imp(false)};
  document.getElementById("rep").onclick=function(){imp(true)};
  document.getElementById("reset").onclick=function(){words.forEach(function(x){x.b=1});save();home("進み具合をリセットしました。")};
}
function imp(replace){
  var t=document.getElementById("ta").value,list=[];
  t.split(/\r?\n/).forEach(function(l){l=l.trim();if(!l)return;var m=l.match(/^([^\t,，]+)[\t,，]\s*(.+)$/);if(m)list.push({w:m[1].trim(),m:m[2].trim(),b:1})});
  if(!list.length){home("読み取れる行がありません。「単語,意味」の形で入力してください。");return}
  if(replace){words=list}else{list.forEach(function(x){if(!words.some(function(y){return y.w===x.w}))words.push(x)})}
  save();home(list.length+"語を読み込みました。");
}
function pick(){
  var pool=words.filter(function(x){return x!==(S&&S.last)}),tot=0,ws=pool.map(function(x){var w=Math.pow(2,5-x.b);tot+=w;return w}),r=Math.random()*tot;
  for(var i=0;i<pool.length;i++){r-=ws[i];if(r<=0)return pool[i]}
  return pool[0];
}
function start(){
  if(words.length<2){home("2語以上必要です。");return}
  S={n:0,total:Math.min(10,words.length),right:0,wrong:[],cur:null,last:null,done:false};next();
}
function next(){
  if(S.n>=S.total){result();return}
  S.cur=pick();S.done=false;
  var others=shuffle(words.filter(function(x){return x.m!==S.cur.m})).slice(0,3).map(function(x){return x.m});
  S.opts=shuffle([S.cur.m].concat(others));
  app.innerHTML='<div class="top"><span>'+(S.n+1)+' / '+S.total+'</span><button id="quit" style="padding:4px 10px;font-size:13px">やめる</button></div>'
  +'<div class="word">'+esc(S.cur.w)+'</div><p class="mute" style="text-align:center">意味はどれ？</p>'
  +'<div class="opts">'+S.opts.map(function(o,i){return'<button class="opt" data-i="'+i+'">'+(i+1)+'. '+esc(o)+'</button>'}).join("")+'</div><div id="fb"></div>';
  document.getElementById("quit").onclick=function(){home()};
  Array.prototype.forEach.call(document.querySelectorAll(".opt"),function(b){b.onclick=function(){ans(+b.dataset.i)}});
}
function ans(i){
  if(S.done)return;S.done=true;
  var ok=S.opts[i]===S.cur.m;
  Array.prototype.forEach.call(document.querySelectorAll(".opt"),function(b,j){b.disabled=true;if(S.opts[j]===S.cur.m)b.classList.add("ok");else if(j===i)b.classList.add("ng")});
  if(ok){S.right++;S.cur.b=Math.min(5,S.cur.b+1)}else{S.wrong.push(S.cur);S.cur.b=1}
  save();S.n++;S.last=S.cur;
  document.getElementById("fb").innerHTML='<p class="fb" style="color:'+(ok?"var(--ok)":"var(--ng)")+'">'+(ok?"正解！":"不正解。「"+esc(S.cur.w)+"」＝"+esc(S.cur.m))+'</p><button class="primary" id="nx" style="margin-top:8px">'+(S.n>=S.total?"結果を見る":"次へ")+'</button>';
  var nx=document.getElementById("nx");nx.onclick=next;nx.focus();
}
function result(){
  var w=S.wrong;
  app.innerHTML='<h1>結果</h1><div class="big">'+S.right+' / '+S.total+'</div>'
  +(w.length?'<h2>間違えた単語（もう一度出します）</h2><ul class="list">'+w.map(function(x){return'<li><b>'+esc(x.w)+'</b><span class="mute">'+esc(x.m)+'</span></li>'}).join("")+'</ul>':'<p style="text-align:center">全問正解です。</p>')
  +'<div class="row" style="margin-top:20px"><button id="h">ホームへ</button><button class="primary" id="again" style="flex:2;width:auto">もう10問</button></div>';
  document.getElementById("h").onclick=function(){home()};
  document.getElementById("again").onclick=start;
}
document.addEventListener("keydown",function(e){
  if(!S||!document.querySelector(".opt")||e.target.tagName==="TEXTAREA")return;
  if(!S.done&&/^[1-4]$/.test(e.key)&&S.opts[+e.key-1]!==undefined)ans(+e.key-1);
});
load();home();
</script>
</body>
</html>
