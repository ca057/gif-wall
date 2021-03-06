# GIF wall

GIF wall which displays random GIFs in an interval from
[GIPHY](https://giphy.com/). Application is running on
[gif.christianost.de](https://gif.christianost.de).

GIF selection can be customized by passing the following URL query parameters:

|   parameter   | default | comment                                                                 |
| :-----------: | :-----: | ----------------------------------------------------------------------- |
|    `tags`     |  party  | the topics to search for as comma delimited string                      |
|   `rating`    |  pg-13  | the rating for searching GIFs                                           |
| `refreshRate` |   10    | the interval in seconds, values equal or lower than 0 will be set to 1s |

For example, the default configuration could be called like the following:

    https://gif.christianost.de?tags=party&rating=pg-13&refreshRate=10

Pass multiple tags to get more randomised GIFs:

    https://gif.christianost.de?tags=party,christmas,bananas

## References

Powered by [GIPHY](https://giphy.com/).

Bootstrapped with
[`create-elm-app`](https://github.com/halfzebra/create-elm-app).
