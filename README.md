# GIF wall

GIF wall which displays random GIFs in an interval from
[GIPHY](https://giphy.com/). Application is running on
[gif.christianost.de](https://gif.christianost.de)

GIF selection can be customized by passing the following URL query parameters:

|   parameter   | default | comment                                                                 |
| :-----------: | :-----: | ----------------------------------------------------------------------- |
|     `tag`     |  party  | the topic to search for                                                 |
|   `rating`    |  pg-13  | the rating for searching GIFs                                           |
| `refreshRate` |   10    | the interval in seconds, values equal or lower than 0 will be set to 1s |

For example, the default configuration could be called like the following:

    https://gif.christianost.de?tag=party&rating=pg-13&refreshRate=10

## References

Powered by [GIPHY](https://giphy.com/).

Bootstrapped with
[`create-elm-app`](https://github.com/halfzebra/create-elm-app).
