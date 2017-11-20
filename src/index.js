import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

// Main.embed(document.getElementById('root'));
const whiteList = {
  tag: true,
  rating: true
};

Main.fullscreen(
  window.location.href
    .substring((window.location.origin + window.location.pathname).length + 1)
    .split('&')
    .map(q => q.split('='))
    .filter(([key]) => whiteList[key])
    .reduce((r, [key, value]) => Object.assign({}, r, { [key]: value }), {
      tag: 'party',
      rating: 'pg-13'
    })
);

registerServiceWorker();
