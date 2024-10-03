 const tg = window.Telegram.WebApp;
 const initData = tg.initData;
 const user = tg.initDataUnsafe.user;

 const urlParams = new URLSearchParams(window.location.search);
 const startParam = urlParams.get('tgWebAppStartParam');

 console.log(urlParams);
 console.log(startParam);

window.state = {
    userData: JSON.stringify(user)
}