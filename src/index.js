import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

const defaultFlags = {
  tags: 'party',
  rating: 'pg-13',
  refreshRate: '10',
  apiKey: process.env.ELM_APP_API_KEY,
};

Main.fullscreen(
  window.location.href
    .substring((window.location.origin + window.location.pathname).length + 1)
    .split('&')
    .map(q => q.split('='))
    .filter(([key]) => defaultFlags[key])
    .reduce(
      (result, [key, value]) => Object.assign(result, { [key]: value }),
      defaultFlags,
    ),
);

registerServiceWorker();
