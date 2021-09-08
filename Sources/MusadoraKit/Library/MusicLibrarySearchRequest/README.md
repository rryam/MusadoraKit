# MusicLibrarySearchRequest

`MusicLibrarySearchRequest` is a request that your app uses to fetch items from your library catalog using a search term.

It is similar to the `MusicCatalogSearchRequest` that is used for searching the Apple Music catalog instead.

You initialize the structure by providing the search term and the list of searchable types. It creates a library search request for it.

```swift
init(term: String, types: [MusicLibrarySearchable.Type])
```

Note that `term` and `types` are **required** properties.

There are two optional properties -
- `limit` for the number of items to return in the library search response. The default number is 5 with a maximum value of 25.
- `offset` to create an offset for the request.

`MusicLibrarySearchRequest` also contains an instance method `response()` that returns the `MusicLibrarySearchResponse`. This response fetches items of the requested library searchable types that match the search term of the request.

The library searchable types are -
- Song
- Artist
- Album
- MusicVideo
- Playlist

Based on the response, you get the `MusicItemCollection` for the requested music items.

## Example

```swift
let request = MusicLibrarySearchRequest(term: "the weeknd", types: [Artist.self, Song.self])
let response = try await request.response()

print(response.songs)
print(response.artists)
```
