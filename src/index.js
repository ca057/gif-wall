import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

// Main.embed(document.getElementById('root'));

Main.fullscreen(
  window.location.href
    .substring((window.location.origin + window.location.pathname).length + 1)
    .split('&')
    .map(q => q.split('='))
    .map(([key, value]) => ({ [key]: value }))
    .reduce((r, c) => Object.assign({}, r, c), {
      tag: 'party'
    })
);

registerServiceWorker();
