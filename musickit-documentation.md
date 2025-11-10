import Combine
import CoreGraphics
import DeveloperToolsSupport
import Foundation

/// A music item that represents an album.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct Album : MusicItem, Equatable, Hashable, Identifiable, Sendable {

    /// The unique identifier for the album.
    public let id: MusicItemID

    /// The album artwork.
    public var artwork: Artwork? { get }

    /// The artist’s name.
    ///
    /// You can find more precise information about this album’s artists
    /// in the ``artists`` relationship, which, unlike ``artistName``,
    /// requires that you load it explicitly using the 
    /// ``MusicPropertyContainer/with(_:)`` method, as in the following example:
    ///
    /// ```swift
    ///     let detailedAlbum = try await album.with([.artists])
    ///     let firstArtist = album.artists?.first
    /// ```
    public var artistName: String { get }

    /// The artist’s URL.
    public var artistURL: URL? { get }

    /// The variants that indicate the quality of audio available for the album.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
    public var audioVariants: [AudioVariant]? { get }

    /// The rating of the content.
    ///
    /// A nil value means no rating is available for this album.
    public var contentRating: ContentRating? { get }

    /// The copyright text for the album.
    public var copyright: String? { get }

    /// The notes about the album that appear in the Music app.
    public var editorialNotes: EditorialNotes? { get }

    /// The names of the album’s associated genres.
    public var genreNames: [String] { get }

    /// A Boolean value that indicates whether the album is
    /// an Apple Digital Master.
    /// 
    /// Apple Digital Masters start from 24-bit files and are 
    /// optimized to bring the best-sounding audio to Apple products.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
    public var isAppleDigitalMaster: Bool? { get }

    /// A Boolean value that indicates whether the album is a compilation.
    public var isCompilation: Bool? { get }

    /// A Boolean value that indicates whether the album is complete.
    ///
    /// If true, the album is complete; otherwise, it’s incomplete.
    /// An album is complete if it contains all its tracks and songs.
    public var isComplete: Bool? { get }

    /// A Boolean value that indicates whether the album consists of a single song.
    public var isSingle: Bool? { get }

    /// The date when the user last played the album on this device.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
    public var lastPlayedDate: Date? { get }

    /// The date when the user added the album to the library.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
    public var libraryAddedDate: Date? { get }

    /// The parameters to use to play the tracks of the album.
    public var playParameters: PlayParameters? { get }

    /// The name of the album’s record label.
    public var recordLabelName: String? { get }

    /// The release date (or expected prerelease date) for the album.
    public var releaseDate: Date? { get }

    /// The title of the album.
    public var title: String { get }

    /// The number of tracks for the album.
    public var trackCount: Int { get }

    /// The universal product code (UPC) for the album.
    public var upc: String? { get }

    /// The URL for the album.
    public var url: URL? { get }

    /// The album’s associated artists.
    public var artists: MusicItemCollection<Artist>? { get }

    /// The genres for the album.
    public var genres: MusicItemCollection<Genre>? { get }

    /// The tracks on the album.
    public var tracks: MusicItemCollection<Track>? { get }

    /// The record labels for the album.
    public var recordLabels: MusicItemCollection<RecordLabel>? { get }

    /// A collection of playlists that include tracks from the album.
    public var appearsOn: MusicItemCollection<Playlist>? { get }

    /// A collection of other versions of the album.
    public var otherVersions: MusicItemCollection<Album>? { get }

    /// A collection of related albums.
    public var relatedAlbums: MusicItemCollection<Album>? { get }

    /// A collection of the album’s music videos.
    public var relatedVideos: MusicItemCollection<MusicVideo>? { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: Album, b: Album) -> Bool

    /// A type representing the stable identity of the entity associated with
    /// an instance.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias ID = MusicItemID

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Album : MusicPropertyContainer {
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension Album : PlayableMusicItem {
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Album : MusicCatalogChartRequestable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Album : MusicCatalogSearchable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Album : FilterableMusicItem {

    /// The associated type that contains the album properties
    /// your app uses as a filter for a catalog resource request.
    public typealias FilterType = AlbumFilter
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
extension Album : MusicLibraryAddable, MusicPlaylistAddable {
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension Album : MusicLibraryRequestable {

    /// The associated type that contains the album properties
    /// your app uses for a library request.
    public typealias LibraryFilter = LibraryAlbumFilter

    /// The associated type that contains the set of album properties
    /// your app uses to sort results for a library request.
    public typealias LibrarySortProperties = LibraryAlbumSortProperties
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension Album : MusicLibrarySectionRequestable {
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension Album : MusicLibrarySearchable {
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Album : MusicPersonalRecommendationItem {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Album : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Album : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// Album properties your app uses as a filter for a catalog resource request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public protocol AlbumFilter {

    /// The unique identifier for the album.
    var id: MusicItemID { get }

    /// The universal product code (UPC) for the album.
    var upc: String? { get }
}

/// A type-erased identifier for a music item property, from any root type
/// to any resulting value type.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public class AnyMusicProperty : Equatable, Hashable, @unchecked Sendable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (left: AnyMusicProperty, right: AnyMusicProperty) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    @objc deinit

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

/// An object your app uses to play music in a way that doesn’t affect
/// the Music app’s state.
///
/// The application music player plays music specifically for your app,
/// and doesn’t affect the Music app’s state.
///
/// If your app includes a background audio mode in your `Info.plist` file,
/// the application music player continues playing the current music item
/// when your app moves to the background.
@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
public class ApplicationMusicPlayer : MusicPlayer {

    /// The shared application music player, which plays music
    /// specifically for your app.
    public static let shared: ApplicationMusicPlayer

    /// The playback queue for the application music player.
    public var queue: ApplicationMusicPlayer.Queue

    /// The transition between items for the application music player.
    ///
    /// By default, the `transition` is `.none` where there is no transition between
    /// playing items.
    ///
    /// Your application should set the desired transition before setting the queue.
    ///
    /// The player cannot apply transitions in all scenarios.
    /// For example, the player does not apply a transition between two consecutive tracks in an album.
    @available(iOS 18.0, *)
    @available(macOS, unavailable)
    @available(macCatalyst, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    @available(visionOS, unavailable)
    public var transition: MusicPlayer.Transition

    @objc deinit
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension ApplicationMusicPlayer {

    public class Queue : MusicPlayer.Queue {

        /// Creates a playback queue with playable music items.
        required public init<S, PlayableMusicItemType>(for playableItems: S, startingAt startPlayableItem: S.Element? = nil) where S : Sequence, PlayableMusicItemType : PlayableMusicItem, PlayableMusicItemType == S.Element

        /// Creates a playback queue with playback queue entries.
        required public init<S>(_ entries: S, startingAt startEntry: S.Element? = nil) where S : Sequence, S.Element == MusicPlayer.Queue.Entry

        required public init(arrayLiteral elements: any PlayableMusicItem...)

        /// Creates a playback queue with an album and a specific track for the player to start playback.
        @available(iOS 16.4, tvOS 16.4, visionOS 1.0, macOS 14.0, *)
        required public init(album: Album, startingAt startTrack: Track)

        /// Creates a playback queue with a playlist and a specific playlist entry for the player to start playback.
        @available(iOS 16.4, tvOS 16.4, visionOS 1.0, macOS 14.0, *)
        required public init(playlist: Playlist, startingAt startPlaylistEntry: Playlist.Entry)

        public var entries: ApplicationMusicPlayer.Queue.Entries

        public struct Entries : Equatable, Hashable, Sequence, Collection, BidirectionalCollection, RandomAccessCollection, MutableCollection, RangeReplaceableCollection, ExpressibleByArrayLiteral {

            /// Creates an empty collection of entries.
            public init()

            /// Returns a Boolean value indicating whether two values are equal.
            ///
            /// Equality is the inverse of inequality. For any values `a` and `b`,
            /// `a == b` implies that `a != b` is `false`.
            ///
            /// - Parameters:
            ///   - lhs: A value to compare.
            ///   - rhs: Another value to compare.
            public static func == (left: ApplicationMusicPlayer.Queue.Entries, right: ApplicationMusicPlayer.Queue.Entries) -> Bool

            /// Hashes the essential components of this value by feeding them into the
            /// given hasher.
            ///
            /// Implement this method to conform to the `Hashable` protocol. The
            /// components used for hashing must be the same as the components compared
            /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
            /// with each of these components.
            ///
            /// - Important: In your implementation of `hash(into:)`,
            ///   don't call `finalize()` on the `hasher` instance provided,
            ///   or replace it with a different instance.
            ///   Doing so may become a compile-time error in the future.
            ///
            /// - Parameter hasher: The hasher to use when combining the components
            ///   of this instance.
            public func hash(into hasher: inout Hasher)

            /// Returns an iterator over the elements of this sequence.
            public func makeIterator() -> ApplicationMusicPlayer.Queue.Entries.Iterator

            /// A type representing the sequence's elements.
            public typealias Element = MusicPlayer.Queue.Entry

            /// A type that provides the sequence's iteration interface and
            /// encapsulates its iteration state.
            public typealias Iterator = Array<MusicPlayer.Queue.Entry>.Iterator

            /// The position of the first element in a nonempty collection.
            ///
            /// If the collection is empty, `startIndex` is equal to `endIndex`.
            public var startIndex: ApplicationMusicPlayer.Queue.Entries.Index { get }

            /// The collection's "past the end" position---that is, the position one
            /// greater than the last valid subscript argument.
            ///
            /// When you need a range that includes the last element of a collection, use
            /// the half-open range operator (`..<`) with `endIndex`. The `..<` operator
            /// creates a range that doesn't include the upper bound, so it's always
            /// safe to use with `endIndex`. For example:
            ///
            ///     let numbers = [10, 20, 30, 40, 50]
            ///     if let index = numbers.firstIndex(of: 30) {
            ///         print(numbers[index ..< numbers.endIndex])
            ///     }
            ///     // Prints "[30, 40, 50]"
            ///
            /// If the collection is empty, `endIndex` is equal to `startIndex`.
            public var endIndex: ApplicationMusicPlayer.Queue.Entries.Index { get }

            /// The indices that are valid for subscripting the collection, in ascending
            /// order.
            ///
            /// A collection's `indices` property can hold a strong reference to the
            /// collection itself, causing the collection to be nonuniquely referenced.
            /// If you mutate the collection while iterating over its indices, a strong
            /// reference can result in an unexpected copy of the collection. To avoid
            /// the unexpected copy, use the `index(after:)` method starting with
            /// `startIndex` to produce indices instead.
            ///
            ///     var c = MyFancyCollection([10, 20, 30, 40, 50])
            ///     var i = c.startIndex
            ///     while i != c.endIndex {
            ///         c[i] /= 5
            ///         i = c.index(after: i)
            ///     }
            ///     // c == MyFancyCollection([2, 4, 6, 8, 10])
            public var indices: ApplicationMusicPlayer.Queue.Entries.Indices { get }

            /// Returns an index that is the specified distance from the given index.
            ///
            /// The following example obtains an index advanced four positions from a
            /// string's starting index and then prints the character at that position.
            ///
            ///     let s = "Swift"
            ///     let i = s.index(s.startIndex, offsetBy: 4)
            ///     print(s[i])
            ///     // Prints "t"
            ///
            /// The value passed as `distance` must not offset `i` beyond the bounds of
            /// the collection.
            ///
            /// - Parameters:
            ///   - i: A valid index of the collection.
            ///   - distance: The distance to offset `i`. `distance` must not be negative
            ///     unless the collection conforms to the `BidirectionalCollection`
            ///     protocol.
            /// - Returns: An index offset by `distance` from the index `i`. If
            ///   `distance` is positive, this is the same value as the result of
            ///   `distance` calls to `index(after:)`. If `distance` is negative, this
            ///   is the same value as the result of `abs(distance)` calls to
            ///   `index(before:)`.
            ///
            /// - Complexity: O(1) if the collection conforms to
            ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
            ///   value of `distance`.
            public func index(_ i: ApplicationMusicPlayer.Queue.Entries.Index, offsetBy distance: Int) -> ApplicationMusicPlayer.Queue.Entries.Index

            /// Returns an index that is the specified distance from the given index,
            /// unless that distance is beyond a given limiting index.
            ///
            /// The following example obtains an index advanced four positions from a
            /// string's starting index and then prints the character at that position.
            /// The operation doesn't require going beyond the limiting `s.endIndex`
            /// value, so it succeeds.
            ///
            ///     let s = "Swift"
            ///     if let i = s.index(s.startIndex, offsetBy: 4, limitedBy: s.endIndex) {
            ///         print(s[i])
            ///     }
            ///     // Prints "t"
            ///
            /// The next example attempts to retrieve an index six positions from
            /// `s.startIndex` but fails, because that distance is beyond the index
            /// passed as `limit`.
            ///
            ///     let j = s.index(s.startIndex, offsetBy: 6, limitedBy: s.endIndex)
            ///     print(j)
            ///     // Prints "nil"
            ///
            /// The value passed as `distance` must not offset `i` beyond the bounds of
            /// the collection, unless the index passed as `limit` prevents offsetting
            /// beyond those bounds.
            ///
            /// - Parameters:
            ///   - i: A valid index of the collection.
            ///   - distance: The distance to offset `i`. `distance` must not be negative
            ///     unless the collection conforms to the `BidirectionalCollection`
            ///     protocol.
            ///   - limit: A valid index of the collection to use as a limit. If
            ///     `distance > 0`, a limit that is less than `i` has no effect.
            ///     Likewise, if `distance < 0`, a limit that is greater than `i` has no
            ///     effect.
            /// - Returns: An index offset by `distance` from the index `i`, unless that
            ///   index would be beyond `limit` in the direction of movement. In that
            ///   case, the method returns `nil`.
            ///
            /// - Complexity: O(1) if the collection conforms to
            ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
            ///   value of `distance`.
            public func index(_ i: ApplicationMusicPlayer.Queue.Entries.Index, offsetBy distance: Int, limitedBy limit: ApplicationMusicPlayer.Queue.Entries.Index) -> ApplicationMusicPlayer.Queue.Entries.Index?

            /// Returns the position immediately after the given index.
            ///
            /// The successor of an index must be well defined. For an index `i` into a
            /// collection `c`, calling `c.index(after: i)` returns the same index every
            /// time.
            ///
            /// - Parameter i: A valid index of the collection. `i` must be less than
            ///   `endIndex`.
            /// - Returns: The index value immediately after `i`.
            public func index(after i: ApplicationMusicPlayer.Queue.Entries.Index) -> ApplicationMusicPlayer.Queue.Entries.Index

            /// Replaces the given index with its successor.
            ///
            /// - Parameter i: A valid index of the collection. `i` must be less than
            ///   `endIndex`.
            public func formIndex(after i: inout ApplicationMusicPlayer.Queue.Entries.Index)

            /// Returns the distance between two indices.
            ///
            /// Unless the collection conforms to the `BidirectionalCollection` protocol,
            /// `start` must be less than or equal to `end`.
            ///
            /// - Parameters:
            ///   - start: A valid index of the collection.
            ///   - end: Another valid index of the collection. If `end` is equal to
            ///     `start`, the result is zero.
            /// - Returns: The distance between `start` and `end`. The result can be
            ///   negative only if the collection conforms to the
            ///   `BidirectionalCollection` protocol.
            ///
            /// - Complexity: O(1) if the collection conforms to
            ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the
            ///   resulting distance.
            public func distance(from start: ApplicationMusicPlayer.Queue.Entries.Index, to end: ApplicationMusicPlayer.Queue.Entries.Index) -> Int

            /// Accesses a contiguous subrange of the collection's elements.
            ///
            /// For example, using a `PartialRangeFrom` range expression with an array
            /// accesses the subrange from the start of the range expression until the
            /// end of the array.
            ///
            ///     let streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
            ///     let streetsSlice = streets[2..<5]
            ///     print(streetsSlice)
            ///     // ["Channing", "Douglas", "Evarts"]
            ///
            /// The accessed slice uses the same indices for the same elements as the
            /// original collection. This example searches `streetsSlice` for one of the
            /// strings in the slice, and then uses that index in the original array.
            ///
            ///     let index = streetsSlice.firstIndex(of: "Evarts")!    // 4
            ///     print(streets[index])
            ///     // "Evarts"
            ///
            /// Always use the slice's `startIndex` property instead of assuming that its
            /// indices start at a particular value. Attempting to access an element by
            /// using an index outside the bounds of the slice may result in a runtime
            /// error, even if that index is valid for the original collection.
            ///
            ///     print(streetsSlice.startIndex)
            ///     // 2
            ///     print(streetsSlice[2])
            ///     // "Channing"
            ///
            ///     print(streetsSlice[0])
            ///     // error: Index out of bounds
            ///
            /// - Parameter bounds: A range of the collection's indices. The bounds of
            ///   the range must be valid indices of the collection.
            ///
            /// - Complexity: O(1)
            public subscript(bounds: Range<ApplicationMusicPlayer.Queue.Entries.Index>) -> ApplicationMusicPlayer.Queue.Entries.SubSequence

            /// Accesses the element at the specified position.
            ///
            /// The following example accesses an element of an array through its
            /// subscript to print its value:
            ///
            ///     var streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
            ///     print(streets[1])
            ///     // Prints "Bryant"
            ///
            /// You can subscript a collection with any valid index other than the
            /// collection's end index. The end index refers to the position one past
            /// the last element of a collection, so it doesn't correspond with an
            /// element.
            ///
            /// - Parameter position: The position of the element to access. `position`
            ///   must be a valid index of the collection that is not equal to the
            ///   `endIndex` property.
            ///
            /// - Complexity: O(1)
            public subscript(position: ApplicationMusicPlayer.Queue.Entries.Index) -> ApplicationMusicPlayer.Queue.Entries.Element

            /// A type that represents a position in the collection.
            ///
            /// Valid indices consist of the position of every element and a
            /// "past the end" position that's not valid for use as a subscript
            /// argument.
            public typealias Index = Array<MusicPlayer.Queue.Entry>.Index

            /// A type that represents the indices that are valid for subscripting the
            /// collection, in ascending order.
            public typealias Indices = Array<MusicPlayer.Queue.Entry>.Indices

            /// A collection representing a contiguous subrange of this collection's
            /// elements. The subsequence shares indices with the original collection.
            ///
            /// The default subsequence type for collections that don't define their own
            /// is `Slice`.
            public typealias SubSequence = Array<MusicPlayer.Queue.Entry>.SubSequence

            /// Returns the position immediately before the given index.
            ///
            /// - Parameter i: A valid index of the collection. `i` must be greater than
            ///   `startIndex`.
            /// - Returns: The index value immediately before `i`.
            public func index(before i: ApplicationMusicPlayer.Queue.Entries.Index) -> ApplicationMusicPlayer.Queue.Entries.Index

            /// Replaces the given index with its predecessor.
            ///
            /// - Parameter i: A valid index of the collection. `i` must be greater than
            ///   `startIndex`.
            public func formIndex(before i: inout ApplicationMusicPlayer.Queue.Entries.Index)

            /// Replaces the specified subrange of elements with the given collection.
            ///
            /// This method has the effect of removing the specified range of elements
            /// from the collection and inserting the new elements at the same location.
            /// The number of new elements need not match the number of elements being
            /// removed.
            ///
            /// In this example, three elements in the middle of an array of integers are
            /// replaced by the five elements of a `Repeated<Int>` instance.
            ///
            ///      var nums = [10, 20, 30, 40, 50]
            ///      nums.replaceSubrange(1...3, with: repeatElement(1, count: 5))
            ///      print(nums)
            ///      // Prints "[10, 1, 1, 1, 1, 1, 50]"
            ///
            /// If you pass a zero-length range as the `subrange` parameter, this method
            /// inserts the elements of `newElements` at `subrange.startIndex`. Calling
            /// the `insert(contentsOf:at:)` method instead is preferred.
            ///
            /// Likewise, if you pass a zero-length collection as the `newElements`
            /// parameter, this method removes the elements in the given subrange
            /// without replacement. Calling the `removeSubrange(_:)` method instead is
            /// preferred.
            ///
            /// Calling this method may invalidate any existing indices for use with this
            /// collection.
            ///
            /// - Parameters:
            ///   - subrange: The subrange of the collection to replace. The bounds of
            ///     the range must be valid indices of the collection.
            ///   - newElements: The new elements to add to the collection.
            ///
            /// - Complexity: O(*n* + *m*), where *n* is length of this collection and
            ///   *m* is the length of `newElements`. If the call to this method simply
            ///   appends the contents of `newElements` to the collection, this method is
            ///   equivalent to `append(contentsOf:)`.
            public mutating func replaceSubrange<C>(_ subrange: Range<ApplicationMusicPlayer.Queue.Entries.Index>, with newElements: C) where C : Collection, C.Element == MusicPlayer.Queue.Entry

            /// Creates an instance initialized with the given elements.
            public init(arrayLiteral elements: MusicPlayer.Queue.Entry...)

            /// The type of the elements of an array literal.
            @available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
            @available(watchOS, unavailable)
            public typealias ArrayLiteralElement = MusicPlayer.Queue.Entry

            /// The hash value.
            ///
            /// Hash values are not guaranteed to be equal across different executions of
            /// your program. Do not save hash values to use during a future execution.
            ///
            /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
            ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
            ///   The compiler provides an implementation for `hashValue` for you.
            public var hashValue: Int { get }
        }

        @objc deinit
    }
}

/// A music item that represents an artist.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct Artist : MusicItem, Equatable, Hashable, Identifiable, Sendable {

    /// The unique identifier for the artist.
    public let id: MusicItemID

    /// The artist artwork.
    public var artwork: Artwork? { get }

    /// The notes about the artist that appear in the Music catalog.
    public var editorialNotes: EditorialNotes? { get }

    /// The names of this artist’s associated genres.
    public var genreNames: [String]? { get }

    /// The date when the user added the artist to the library.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
    public var libraryAddedDate: Date? { get }

    /// The name of the artist.
    public var name: String { get }

    /// The URL for the artist.
    public var url: URL? { get }

    /// The artist’s associated albums.
    public var albums: MusicItemCollection<Album>? { get }

    /// The artist’s associated genres.
    public var genres: MusicItemCollection<Genre>? { get }

    /// The artist’s associated music videos.
    public var musicVideos: MusicItemCollection<MusicVideo>? { get }

    /// The artist’s associated playlists.
    public var playlists: MusicItemCollection<Playlist>? { get }

    /// The artist’s associated station.
    public var station: Station? { get }

    /// A collection of albums from other artists that this artist appears on.
    public var appearsOnAlbums: MusicItemCollection<Album>? { get }

    /// A collection of compilation albums that include tracks by the artist.
    public var compilationAlbums: MusicItemCollection<Album>? { get }

    /// A collection of featured albums of the artist.
    public var featuredAlbums: MusicItemCollection<Album>? { get }

    /// A collection of the artist’s associated playlists.
    public var featuredPlaylists: MusicItemCollection<Playlist>? { get }

    /// A collection of the artist’s full-release albums.
    public var fullAlbums: MusicItemCollection<Album>? { get }

    /// The artist’s most recent album.
    public var latestRelease: Album? { get }

    /// A collection of the artist’s live albums.
    public var liveAlbums: MusicItemCollection<Album>? { get }

    /// A collection of artists similar to this artist.
    public var similarArtists: MusicItemCollection<Artist>? { get }

    /// A collection of the artist’s associated albums in the _singles_ category.
    public var singles: MusicItemCollection<Album>? { get }

    /// A collection of the artist’s top music videos.
    public var topMusicVideos: MusicItemCollection<MusicVideo>? { get }

    /// A collection of the artist’s top songs.
    public var topSongs: MusicItemCollection<Song>? { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: Artist, b: Artist) -> Bool

    /// A type representing the stable identity of the entity associated with
    /// an instance.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias ID = MusicItemID

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Artist : MusicPropertyContainer {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Artist : MusicCatalogSearchable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Artist : FilterableMusicItem {

    /// The associated type that contains the artist properties
    /// your app uses as a filter for a catalog resource request.
    public typealias FilterType = ArtistFilter
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension Artist : MusicLibraryRequestable {

    /// The associated type that contains the artist properties
    /// your app uses for a library request.
    public typealias LibraryFilter = LibraryArtistFilter

    /// The associated type that contains the set of artist properties
    /// your app uses to sort results for a library request.
    public typealias LibrarySortProperties = LibraryArtistSortProperties
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension Artist : MusicLibrarySectionRequestable {
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension Artist : MusicLibrarySearchable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Artist : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Artist : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// Artist properties your app uses as a filter for a catalog resource request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public protocol ArtistFilter {

    /// The unique identifier for the artist.
    var id: MusicItemID { get }
}

/// An object that represents artwork for a music item.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct Artwork : Equatable, Hashable, Sendable {

    /// The maximum width available for the image.
    public let maximumWidth: Int

    /// The maximum height available for the image.
    public let maximumHeight: Int

    /// A textual description for the image.
    public let alternateText: String?

    /// The average background color of the image.
    public let backgroundColor: CGColor?

    /// The primary text color to use when displaying the background color.
    public let primaryTextColor: CGColor?

    /// The secondary text color to use when displaying the background color.
    public let secondaryTextColor: CGColor?

    /// The tertiary text color to use when displaying the background color.
    public let tertiaryTextColor: CGColor?

    /// The final posttertiary text color to use when displaying
    /// the background color.
    public let quaternaryTextColor: CGColor?

    /// Returns a URL to request the image asset for a specified
    /// width and height.
    public func url(width: Int, height: Int) -> URL?

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: Artwork, b: Artwork) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Artwork : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Artwork : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// Variants that indicate the quality of audio available for an item.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public enum AudioVariant : CaseIterable, Equatable, Hashable, Sendable {

    /// Dolby Atmos is an immersive audio experience that surrounds you with sound from all sides, including above.
    case dolbyAtmos

    /// Dolby Audio is a surround sound format that includes Dolby 5.1 and 7.1.
    case dolbyAudio

    /// Lossless uses Apple Lossless Audio Codec (ALAC)
    /// for bit-for-bit accuracy up to 24-bit/48 kHz.
    case lossless

    /// Hi-Res Lossless uses Apple Lossless Audio Codec (ALAC) 
    /// for bit-for-bit accuracy up to 24-bit/192 kHz.
    case highResolutionLossless

    /// Lossy stereo uses compression used to store sound data.
    case lossyStereo

    /// Spatial audio is a fallback mode if the content is Dolby Atmos or Dolby Audio,
    /// but hardware capabilities don’t support them.
    @available(iOS 17.2, macOS 14.2, tvOS 17.2, watchOS 10.2, visionOS 1.1, *)
    case spatialAudio

    /// A collection of all values of this type.
    public static var allCases: [AudioVariant] { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: AudioVariant, b: AudioVariant) -> Bool

    /// A type that can represent a collection of all values of this type.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 13.0, *)
    public typealias AllCases = [AudioVariant]

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension AudioVariant : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension AudioVariant : CustomStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }
}

/// The rating of the content that potentially plays while playing a resource.
///
/// A nil value means no rating is available for this resource.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public enum ContentRating : Codable, Equatable, Hashable, Sendable {

    case clean

    case explicit

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: ContentRating, b: ContentRating) -> Bool

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws
}

/// A music item that represents a curator.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
public struct Curator : MusicItem, Equatable, Hashable, Identifiable, Sendable {

    /// The unique identifier for the curator.
    public let id: MusicItemID

    /// The curator artwork.
    public var artwork: Artwork? { get }

    /// The notes about the curator that appear in the Music catalog.
    public var editorialNotes: EditorialNotes? { get }

    /// The kind of curator.
    public var kind: Curator.Kind { get }

    /// The name of the curator.
    public var name: String { get }

    /// The URL for the curator.
    public var url: URL? { get }

    /// The curator’s associated playlists.
    public var playlists: MusicItemCollection<Playlist>? { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: Curator, b: Curator) -> Bool

    /// A type representing the stable identity of the entity associated with
    /// an instance.
    @available(iOS 15.4, tvOS 15.4, watchOS 9.0, visionOS 1.0, macOS 12.3, *)
    public typealias ID = MusicItemID

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
extension Curator : MusicPropertyContainer {
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
extension Curator : MusicCatalogSearchable {
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
extension Curator : FilterableMusicItem {

    /// The associated type that contains the curator properties
    /// your app uses as a filter for a catalog resource request.
    public typealias FilterType = CuratorFilter
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
extension Curator : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
extension Curator : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
extension Curator {

    /// The available kinds of curators.
    public enum Kind : Codable, Equatable, Hashable, Sendable {

        /// Indicates that the curator is an Apple Music curator.
        case editorial

        /// Indicates that the curator is an external, third-party curator.
        case external

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: Curator.Kind, b: Curator.Kind) -> Bool

        /// Encodes this value into the given encoder.
        ///
        /// If the value fails to encode anything, `encoder` will encode an empty
        /// keyed container in its place.
        ///
        /// This function throws an error if any values are invalid for the given
        /// encoder's format.
        ///
        /// - Parameter encoder: The encoder to write data to.
        public func encode(to encoder: any Encoder) throws

        /// Hashes the essential components of this value by feeding them into the
        /// given hasher.
        ///
        /// Implement this method to conform to the `Hashable` protocol. The
        /// components used for hashing must be the same as the components compared
        /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
        /// with each of these components.
        ///
        /// - Important: In your implementation of `hash(into:)`,
        ///   don't call `finalize()` on the `hasher` instance provided,
        ///   or replace it with a different instance.
        ///   Doing so may become a compile-time error in the future.
        ///
        /// - Parameter hasher: The hasher to use when combining the components
        ///   of this instance.
        public func hash(into hasher: inout Hasher)

        /// The hash value.
        ///
        /// Hash values are not guaranteed to be equal across different executions of
        /// your program. Do not save hash values to use during a future execution.
        ///
        /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
        ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
        ///   The compiler provides an implementation for `hashValue` for you.
        public var hashValue: Int { get }

        /// Creates a new instance by decoding from the given decoder.
        ///
        /// This initializer throws an error if reading from the decoder fails, or
        /// if the data read is corrupted or otherwise invalid.
        ///
        /// - Parameter decoder: The decoder to read data from.
        public init(from decoder: any Decoder) throws
    }
}

/// Curator properties your app uses as a filter for a catalog resource request.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
public protocol CuratorFilter {

    /// The unique identifier for the curator.
    var id: MusicItemID { get }
}

/// The default token provider that music requests use to access
/// Apple Music API.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public class DefaultMusicTokenProvider : MusicTokenProvider, @unchecked Sendable {

    /// Fetches and returns a developer token for Apple Music API.
    ///
    /// If you opt to create a custom implementation of the
    /// ``MusicDeveloperTokenProvider`` protocol, make sure to discard
    /// any cached developer token if the `options` parameter contains
    /// ``MusicTokenRequestOptions/ignoreCache``.
    ///
    /// You can add the newly generated token to an in-memory or persistent
    /// cache for faster access upon subsequent requests for this token.
    public func developerToken(options: MusicTokenRequestOptions) async throws -> String

    /// Creates a user token provider.
    override public init()

    @objc deinit
}

/// An object that represents editorial notes.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct EditorialNotes : Equatable, Hashable, Sendable {

    /// Abbreviated notes that display inline or when the content
    /// appears alongside other content.
    public let short: String?

    /// Notes that appear when the content displays prominently.
    public let standard: String?

    /// The name for the editorial notes.
    public let name: String?

    /// The tag line for the editorial notes.
    public let tagline: String?

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: EditorialNotes, b: EditorialNotes) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension EditorialNotes : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension EditorialNotes : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// A declaration of the associated type that contains the set of music item
/// properties your app uses as a filter for a catalog resource request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public protocol FilterableMusicItem : MusicItem {

    /// The associated type that contains the set of music item properties
    /// your app uses as a filter for a catalog resource request.
    associatedtype FilterType
}

/// A music item that represents a genre.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct Genre : MusicItem, Equatable, Hashable, Identifiable, Sendable {

    /// The unique identifier for the genre.
    public let id: MusicItemID

    /// The localized name of the genre.
    public var name: String { get }

    /// The parent genre, if any.
    public var parent: Genre? { get }

    /// The date when the user added the genre to the library.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 15.2, macCatalyst 18.2, *)
    public var libraryAddedDate: Date? { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: Genre, b: Genre) -> Bool

    /// A type representing the stable identity of the entity associated with
    /// an instance.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias ID = MusicItemID

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Genre : MusicPropertyContainer {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Genre : FilterableMusicItem {

    /// The associated type that contains the set of genre properties
    /// your app uses as a filter for a catalog resource request.
    public typealias FilterType = GenreFilter
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Genre : MusicCatalogTopLevelResourceRequesting {
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension Genre : MusicLibraryRequestable {

    /// The associated type that contains the genre properties
    /// your app uses for a library request.
    public typealias LibraryFilter = LibraryGenreFilter

    /// The associated type that contains the set of genre properties
    /// your app uses to sort results for a library request.
    public typealias LibrarySortProperties = LibraryGenreSortProperties
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.2, macCatalyst 17.2, *)
extension Genre : MusicLibrarySectionRequestable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Genre : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Genre : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// Genre properties your app uses as a filter for a catalog resource request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public protocol GenreFilter {

    /// The unique identifier for the genre.
    var id: MusicItemID { get }
}

/// Album properties your app uses as a filter for a library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol LibraryAlbumFilter {

    /// The unique identifier for the album.
    var id: MusicItemID { get }

    /// A Boolean value that indicates whether the album is a compilation.
    var isCompilation: Bool? { get }

    /// The album’s associated artists.
    var artists: MusicItemCollection<Artist>? { get }

    /// The genres for the album.
    var genres: MusicItemCollection<Genre>? { get }

    /// The title of the album.
    var title: String { get }

    /// The artist’s name.
    var artistName: String { get }
}

/// Album properties your app uses to sort results for a library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol LibraryAlbumSortProperties {

    /// The artist’s name.
    var artistName: String { get }

    /// The release date (or expected prerelease date) for the album.
    var releaseDate: Date? { get }

    /// The title of the album.
    var title: String { get }

    /// The number of tracks for the album.
    var trackCount: Int { get }

    /// The date when the user last played the album on this device.
    var lastPlayedDate: Date? { get }

    /// The date when the user added the album to the library.
    var libraryAddedDate: Date? { get }
}

/// Artist properties your app uses as a filter for a library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol LibraryArtistFilter {

    /// The unique identifier for the artist.
    var id: MusicItemID { get }

    /// The artist’s associated genres.
    var genres: MusicItemCollection<Genre>? { get }

    /// The artist’s associated playlists.
    var playlists: MusicItemCollection<Playlist>? { get }

    /// The name of the artist.
    var name: String { get }
}

/// Artist properties your app uses to sort results for a library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol LibraryArtistSortProperties {

    /// The number of albums from this artist.
    var albumCount: Int? { get }

    /// The date when the user added the artist to the library.
    var libraryAddedDate: Date? { get }

    /// The name of the artist.
    var name: String { get }
}

/// Genre properties your app uses as a filter for a library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol LibraryGenreFilter {

    /// The unique identifier for the genre.
    var id: MusicItemID { get }

    /// The localized name of the genre.
    var name: String { get }
}

/// Genre properties your app uses to sort results for a library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol LibraryGenreSortProperties {

    /// The date when the user added the genre to the library.
    var libraryAddedDate: Date? { get }

    /// The localized name of the genre.
    var name: String { get }
}

/// Music video properties your app uses as a filter for a library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol LibraryMusicVideoFilter {

    /// The unique identifier for the music video.
    var id: MusicItemID { get }

    /// The music video’s associated albums.
    var albums: MusicItemCollection<Album>? { get }

    /// The music video’s associated artists.
    var artists: MusicItemCollection<Artist>? { get }

    /// The music video’s associated genres.
    var genres: MusicItemCollection<Genre>? { get }

    /// The title of the album the music video appears on.
    var albumTitle: String? { get }

    /// The artist’s name.
    var artistName: String? { get }

    /// The title of the music video.
    var title: String { get }
}

/// Music video properties your app uses to sort results for a library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol LibraryMusicVideoSortProperties {

    /// The title of the album the music video appears on.
    var albumTitle: String? { get }

    /// The artist’s name.
    var artistName: String? { get }

    /// The duration of the music video.
    var duration: TimeInterval? { get }

    /// The date when the user last played the music video on this device.
    var lastPlayedDate: Date? { get }

    /// The date when the user added the music video to the library.
    var libraryAddedDate: Date? { get }

    /// The number of times the user played the music video.
    var playCount: Int? { get }

    /// The title of the music video.
    var title: String { get }

    /// The music video’s number in the album’s track list.
    var trackNumber: Int? { get }
}

/// Playlist entry properties your app uses as a filter for a library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol LibraryPlaylistEntryFilter {

    /// The unique identifier for the playlist entry.
    var id: MusicItemID { get }
}

/// Playlist entry properties your app uses to sort results for a library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol LibraryPlaylistEntrySortProperties {
}

/// Playlist properties your app uses as a filter for a library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol LibraryPlaylistFilter {

    /// The unique identifier for the playlist.
    var id: MusicItemID { get }

    /// The name of the playlist.
    var name: String { get }
}

/// Playlist properties your app uses to sort results for a library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol LibraryPlaylistSortProperties {

    /// The date when the user last played the playlist on this device.
    var lastPlayedDate: Date? { get }

    /// The date when the user added the playlist to the library.
    var libraryAddedDate: Date? { get }

    /// The name of the playlist.
    var name: String { get }
}

/// Song properties your app uses as a filter for a library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol LibrarySongFilter {

    /// The unique identifier for the song.
    var id: MusicItemID { get }

    /// The song’s associated albums.
    var albums: MusicItemCollection<Album>? { get }

    /// The song’s associated artists.
    var artists: MusicItemCollection<Artist>? { get }

    /// The song’s associated genres.
    var genres: MusicItemCollection<Genre>? { get }

    /// The title of the album the song appears on.
    var albumTitle: String? { get }

    /// The artist’s name.
    var artistName: String? { get }

    /// The name of the song’s composer.
    var composerName: String? { get }

    /// The title of the song.
    var title: String { get }
}

/// Song properties your app uses to sort results for a library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol LibrarySongSortProperties {

    /// The title of the album the song appears on.
    var albumTitle: String? { get }

    /// The artist’s name.
    var artistName: String? { get }

    /// The name of the song’s composer.
    var composerName: String? { get }

    /// The disc number of the song.
    var discNumber: Int? { get }

    /// The duration of the song.
    var duration: TimeInterval? { get }

    /// The date when the user last played the song on this device.
    var lastPlayedDate: Date? { get }

    /// The date when the user added the song to the library.
    var libraryAddedDate: Date? { get }

    /// The number of times the user played the song.
    var playCount: Int? { get }

    /// The title of the song.
    var title: String { get }

    /// The song’s number in the album’s track list.
    var trackNumber: Int? { get }
}

/// Track properties your app uses as a filter for a library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol LibraryTrackFilter {

    /// The unique identifier for the track.
    var id: MusicItemID { get }

    /// The track’s associated albums.
    var albums: MusicItemCollection<Album>? { get }

    /// The track’s associated artists.
    var artists: MusicItemCollection<Artist>? { get }

    /// The track’s associated genres.
    var genres: MusicItemCollection<Genre>? { get }

    /// The title of the album the track appears on.
    var albumTitle: String? { get }

    /// The artist’s name.
    var artistName: String? { get }

    /// The title of the track.
    var title: String { get }
}

/// Track properties your app uses to sort results for a library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol LibraryTrackSortProperties {

    /// The title of the album the track appears on.
    var albumTitle: String? { get }

    /// The artist’s name.
    var artistName: String? { get }

    /// The disc number of the track.
    var discNumber: Int? { get }

    /// The duration of the track.
    var duration: TimeInterval? { get }

    /// The date when the user last played the track on this device.
    var lastPlayedDate: Date? { get }

    /// The date when the user added the track to the library.
    var libraryAddedDate: Date? { get }

    /// The number of times the user played the track.
    var playCount: Int? { get }

    /// The title of the track.
    var title: String { get }

    /// The track’s number in the album’s track list.
    var trackNumber: Int? { get }
}

/// An identifier for a music item attribute property
/// from a specific root type to a specific resulting value type.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public class MusicAttributeProperty<Root, Value> : PartialMusicProperty<Root>, CustomStringConvertible, @unchecked Sendable where Value : Decodable {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    @objc deinit
}

/// A type that allows you to request the user’s informed consent
/// for your app to access their music data.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct MusicAuthorization {

    /// The authorization status the user sets for accessing MusicKit.
    public static var currentStatus: MusicAuthorization.Status { get }

    /// Asks the user for permission for the current app to access MusicKit.
    ///
    /// Before using any other MusicKit API in your app, make sure the user
    /// grants your app access to their Apple Music data,
    /// You can do this either by comparing
    /// ``MusicAuthorization/currentStatus``
    /// to ``MusicAuthorization/Status/authorized``, or by simply calling
    /// ``MusicAuthorization/request()`` regardless of the current
    /// authorization status value. Calling ``MusicAuthorization/request()``
    /// results in presenting a standard user consent dialog
    /// to the user when necessary.
    /// 
    /// Requesting authorization to use MusicKit requires the inclusion of
    /// a short description of the app’s reason for using MusicKit.
    /// You need to add this purpose string to the app’s `Info.plist` file
    /// using the [NSAppleMusicUsageDescription](<doc://com.apple.documentation/documentation/bundleresources/information_property_list/nsapplemusicusagedescription>) key.
    public static func request() async -> MusicAuthorization.Status
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicAuthorization {

    /// A value that indicates the authorization status the user sets
    /// for the current app to access their Apple Music data.
    public enum Status : String, Sendable {

        /// The user has yet to decide whether to authorize the current app
        /// to use MusicKit.
        case notDetermined

        /// The user denied permission for the current app to use MusicKit.
        ///
        /// On iOS, applications may attempt to recover from this situation
        /// by suggesting to their users that they can grant access to their
        /// Apple Music data again by linking to
        /// <doc://com.apple.documentation/documentation/UIKit/UIApplication/1623042-openSettingsURLString>.
        case denied

        /// Apps on this device can’t access MusicKit in a way
        /// that the user can’t change.
        ///
        /// In this scenario, don’t prompt for authorization.
        ///
        /// An example of this situation is when the device is
        /// in education mode.
        case restricted

        /// The user granted permission for the current app to use MusicKit.
        case authorized

        /// Creates a new instance with the specified raw value.
        ///
        /// If there is no value of the type that corresponds with the specified raw
        /// value, this initializer returns `nil`. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     print(PaperSize(rawValue: "Legal"))
        ///     // Prints "Optional(PaperSize.Legal)"
        ///
        ///     print(PaperSize(rawValue: "Tabloid"))
        ///     // Prints "nil"
        ///
        /// - Parameter rawValue: The raw value to use for the new instance.
        public init?(rawValue: String)

        /// The raw type that can be used to represent all values of the conforming
        /// type.
        ///
        /// Every distinct value of the conforming type has a corresponding unique
        /// value of the `RawValue` type, but there may be values of the `RawValue`
        /// type that don't have a corresponding value of the conforming type.
        @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
        public typealias RawValue = String

        /// The corresponding value of the raw type.
        ///
        /// A new instance initialized with `rawValue` will be equivalent to this
        /// instance. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     let selectedSize = PaperSize.Letter
        ///     print(selectedSize.rawValue)
        ///     // Prints "Letter"
        ///
        ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
        ///     // Prints "true"
        public var rawValue: String { get }
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicAuthorization.Status : CustomStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicAuthorization.Status : Equatable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicAuthorization.Status : Hashable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicAuthorization.Status : RawRepresentable {
}

/// An object that contains popular items in the Apple Music catalog.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public struct MusicCatalogChart<MusicItemType> : Identifiable where MusicItemType : MusicCatalogChartRequestable {

    /// The unique identifier for the catalog chart.
    public let id: String

    /// The kind of catalog chart.
    public let kind: MusicCatalogChartKind

    /// The title for the catalog chart.
    public let title: String

    /// The items for the catalog chart.
    public let items: MusicItemCollection<MusicItemType>

    /// A type representing the stable identity of the entity associated with
    /// an instance.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 13.0, *)
    public typealias ID = String
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogChart : Equatable where MusicItemType : Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicCatalogChart<MusicItemType>, b: MusicCatalogChart<MusicItemType>) -> Bool
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogChart : Hashable where MusicItemType : Hashable {

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogChart : Sendable {
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogChart : Decodable where MusicItemType : Decodable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogChart : Encodable where MusicItemType : Encodable {

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogChart : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// The available kinds of catalog charts.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public enum MusicCatalogChartKind : CaseIterable, Equatable, Hashable, Sendable {

    case mostPlayed

    case cityTop

    case dailyGlobalTop

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicCatalogChartKind, b: MusicCatalogChartKind) -> Bool

    /// A type that can represent a collection of all values of this type.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 13.0, *)
    public typealias AllCases = [MusicCatalogChartKind]

    /// A collection of all values of this type.
    nonisolated public static var allCases: [MusicCatalogChartKind] { get }

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogChartKind : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogChartKind : CustomStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }
}

/// A protocol for music items that your app can fetch by
/// using a catalog charts request.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public protocol MusicCatalogChartRequestable : MusicItem {
}

/// A request that your app uses to fetch the most popular items
/// in the Apple Music catalog.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public struct MusicCatalogChartsRequest : Equatable, Hashable, Sendable {

    /// Creates a catalog charts request for a specified genre
    /// and list of types to include in the catalog charts response.
    public init(genre: Genre? = nil, kinds: [MusicCatalogChartKind] = [.mostPlayed], types: [any MusicCatalogChartRequestable.Type])

    /// The genre for the request.
    public var genre: Genre? { get }

    /// The kinds of requested catalog charts.
    public var kinds: [MusicCatalogChartKind] { get }

    /// The list of requested types for the catalog charts response.
    public var types: [any MusicCatalogChartRequestable.Type] { get }

    /// A limit for the number of items to return
    /// in the catalog search response.
    public var limit: Int?

    /// An offet for the request.
    public var offset: Int?

    /// Fetches the most popular items of the requested types that match
    /// the genre and kinds for the request.
    public func response() async throws -> MusicCatalogChartsResponse

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicCatalogChartsRequest, b: MusicCatalogChartsRequest) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

/// An object that contains results for a catalog charts request.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public struct MusicCatalogChartsResponse : Equatable, Hashable, Sendable {

    /// A collection of charts that contain albums.
    public let albumCharts: [MusicCatalogChart<Album>]

    /// A collection of charts that contain music videos.
    public let musicVideoCharts: [MusicCatalogChart<MusicVideo>]

    /// A collection of charts that contain playlists.
    public let playlistCharts: [MusicCatalogChart<Playlist>]

    /// A collection of charts that contain songs.
    public let songCharts: [MusicCatalogChart<Song>]

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicCatalogChartsResponse, b: MusicCatalogChartsResponse) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogChartsResponse : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogChartsResponse : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// A request that your app uses to fetch items from the Apple Music catalog
/// using a filter.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct MusicCatalogResourceRequest<MusicItemType> : Sendable where MusicItemType : MusicItem, MusicItemType : Decodable {

    /// Creates a request to fetch top-level items in the Apple Music catalog.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
    public init() where MusicItemType : MusicCatalogTopLevelResourceRequesting

    /// Creates a request to fetch items using a filter that matches
    /// a specific value.
    public init<Value>(matching keyPath: KeyPath<MusicItemType.FilterType, Value>, equalTo value: Value) where MusicItemType : FilterableMusicItem

    /// Creates a request to fetch items using a filter that matches
    /// any value from an array of possible values.
    public init<Value>(matching keyPath: KeyPath<MusicItemType.FilterType, Value>, memberOf values: [Value]) where MusicItemType : FilterableMusicItem

    /// A limit for the number of items to return
    /// in the catalog resource response.
    public var limit: Int?

    /// A list of properties which the resource request will fetch
    /// for each music item in the response.
    public var properties: [PartialMusicAsyncProperty<MusicItemType>]

    /// Fetches items from the Apple Music catalog that match a specific filter.
    public func response() async throws -> MusicCatalogResourceResponse<MusicItemType>
}

/// An object that contains results for a catalog resource request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct MusicCatalogResourceResponse<MusicItemType> where MusicItemType : MusicItem {

    /// A collection of items matching the filter used in
    /// the originating ``MusicCatalogResourceRequest``.
    public let items: MusicItemCollection<MusicItemType>
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicCatalogResourceResponse : Equatable where MusicItemType : Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicCatalogResourceResponse<MusicItemType>, b: MusicCatalogResourceResponse<MusicItemType>) -> Bool
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicCatalogResourceResponse : Hashable where MusicItemType : Hashable {

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicCatalogResourceResponse : Sendable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicCatalogResourceResponse : Decodable where MusicItemType : Decodable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicCatalogResourceResponse : Encodable where MusicItemType : Encodable {

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicCatalogResourceResponse : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// A request that your app uses to fetch items from the Apple Music catalog
/// using a search term.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct MusicCatalogSearchRequest {

    /// Creates a catalog search request for a specified search term
    /// and list of catalog searchable types.
    public init(term: String, types: [any MusicCatalogSearchable.Type])

    /// The search term for the request.
    public let term: String

    /// The list of requested catalog searchable types.
    public var types: [any MusicCatalogSearchable.Type] { get }

    /// A limit for the number of items to return
    /// in the catalog search response.
    public var limit: Int?

    /// An offet for the request.
    public var offset: Int?

    /// A Boolean value that indicates whether to request top search results.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
    public var includeTopResults: Bool

    /// Fetches items of the requested catalog searchable types that match
    /// the search term of the request.
    public func response() async throws -> MusicCatalogSearchResponse
}

/// An object that contains results for a catalog search request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct MusicCatalogSearchResponse : Equatable, Hashable {

    /// A collection of albums.
    public let albums: MusicItemCollection<Album>

    /// A collection of artists.
    public let artists: MusicItemCollection<Artist>

    /// A collection of curators.
    @available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
    public let curators: MusicItemCollection<Curator>

    /// A collection of music videos.
    @available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
    public let musicVideos: MusicItemCollection<MusicVideo>

    /// A collection of playlists.
    public let playlists: MusicItemCollection<Playlist>

    /// A collection of radio shows.
    @available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
    public let radioShows: MusicItemCollection<RadioShow>

    /// A collection of record labels.
    public let recordLabels: MusicItemCollection<RecordLabel>

    /// A collection of songs.
    public let songs: MusicItemCollection<Song>

    /// A collection of stations.
    public let stations: MusicItemCollection<Station>

    /// A collection of top results.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
    public let topResults: MusicItemCollection<MusicCatalogSearchResponse.TopResult>

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicCatalogSearchResponse, b: MusicCatalogSearchResponse) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogSearchResponse {

    /// An item that represents one of the top results in a catalog search response.
    public enum TopResult : MusicItem, Equatable, Hashable, Identifiable, Sendable {

        /// An item that corresponds to an album.
        case album(Album)

        /// An item that corresponds to an artist.
        case artist(Artist)

        /// An item that corresponds to a curator.
        case curator(Curator)

        /// An item that corresponds to a music video.
        case musicVideo(MusicVideo)

        /// An item that corresponds to a playlist.
        case playlist(Playlist)

        /// An item that corresponds to a radio show.
        case radioShow(RadioShow)

        /// An item that corresponds to a record label.
        case recordLabel(RecordLabel)

        /// An item that corresponds to a song.
        case song(Song)

        /// An item that corresponds to a station.
        case station(Station)

        /// The unique identifier of this top result for catalog search.
        public var id: MusicItemID { get }

        /// The artwork of this top result for catalog search.
        public var artwork: Artwork? { get }

        /// The title of this top result for catalog search.
        public var title: String { get }

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: MusicCatalogSearchResponse.TopResult, b: MusicCatalogSearchResponse.TopResult) -> Bool

        /// A type representing the stable identity of the entity associated with
        /// an instance.
        @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 13.0, *)
        public typealias ID = MusicItemID

        /// Hashes the essential components of this value by feeding them into the
        /// given hasher.
        ///
        /// Implement this method to conform to the `Hashable` protocol. The
        /// components used for hashing must be the same as the components compared
        /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
        /// with each of these components.
        ///
        /// - Important: In your implementation of `hash(into:)`,
        ///   don't call `finalize()` on the `hasher` instance provided,
        ///   or replace it with a different instance.
        ///   Doing so may become a compile-time error in the future.
        ///
        /// - Parameter hasher: The hasher to use when combining the components
        ///   of this instance.
        public func hash(into hasher: inout Hasher)

        /// The hash value.
        ///
        /// Hash values are not guaranteed to be equal across different executions of
        /// your program. Do not save hash values to use during a future execution.
        ///
        /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
        ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
        ///   The compiler provides an implementation for `hashValue` for you.
        public var hashValue: Int { get }
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicCatalogSearchResponse : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicCatalogSearchResponse : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogSearchResponse.TopResult : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogSearchResponse.TopResult : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// A request that your app uses to fetch suggestions from the Apple Music catalog
/// using a search term.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public struct MusicCatalogSearchSuggestionsRequest {

    /// Creates a catalog search suggestions request for a specified search term
    /// along with a list of types to include when fetching top results.
    /// 
    /// By default, top results are not fetched.
    public init(term: String, includingTopResultsOfTypes types: [any MusicCatalogSearchable.Type] = [])

    /// The search term for the request.
    public let term: String

    /// The list of requested types for top results.
    public var typesForTopResults: [any MusicCatalogSearchable.Type] { get }

    /// A limit for the number of items to return
    /// in the catalog search suggestions response.
    public var limit: Int?

    /// Fetches suggestions of the requested catalog searchable types that match
    /// the search term of the request.
    public func response() async throws -> MusicCatalogSearchSuggestionsResponse
}

/// An object that contains results for a catalog search suggestions request.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public struct MusicCatalogSearchSuggestionsResponse : Equatable, Hashable, Sendable {

    /// A type alias for an item that represents one of
    /// the top results in a catalog search suggestions response.
    public typealias TopResult = MusicCatalogSearchResponse.TopResult

    /// A collection of suggested terms.
    public let suggestions: [MusicCatalogSearchSuggestionsResponse.Suggestion]

    /// A collection of top results.
    public let topResults: MusicItemCollection<MusicCatalogSearchSuggestionsResponse.TopResult>

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicCatalogSearchSuggestionsResponse, b: MusicCatalogSearchSuggestionsResponse) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogSearchSuggestionsResponse {

    /// An item that represents a suggestion in the search suggestions response.
    public struct Suggestion : Codable, Equatable, Hashable, Identifiable, Sendable {

        /// The unique identifier for the suggestion.
        public var id: String { get }

        /// A term to display to the user to select from.
        ///
        /// Use the ``searchTerm`` value for the actual search.
        public let displayTerm: String

        /// The term to use as a search input when using this suggestion.
        public let searchTerm: String

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: MusicCatalogSearchSuggestionsResponse.Suggestion, b: MusicCatalogSearchSuggestionsResponse.Suggestion) -> Bool

        /// A type representing the stable identity of the entity associated with
        /// an instance.
        @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 13.0, *)
        public typealias ID = String

        /// Encodes this value into the given encoder.
        ///
        /// If the value fails to encode anything, `encoder` will encode an empty
        /// keyed container in its place.
        ///
        /// This function throws an error if any values are invalid for the given
        /// encoder's format.
        ///
        /// - Parameter encoder: The encoder to write data to.
        public func encode(to encoder: any Encoder) throws

        /// Hashes the essential components of this value by feeding them into the
        /// given hasher.
        ///
        /// Implement this method to conform to the `Hashable` protocol. The
        /// components used for hashing must be the same as the components compared
        /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
        /// with each of these components.
        ///
        /// - Important: In your implementation of `hash(into:)`,
        ///   don't call `finalize()` on the `hasher` instance provided,
        ///   or replace it with a different instance.
        ///   Doing so may become a compile-time error in the future.
        ///
        /// - Parameter hasher: The hasher to use when combining the components
        ///   of this instance.
        public func hash(into hasher: inout Hasher)

        /// The hash value.
        ///
        /// Hash values are not guaranteed to be equal across different executions of
        /// your program. Do not save hash values to use during a future execution.
        ///
        /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
        ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
        ///   The compiler provides an implementation for `hashValue` for you.
        public var hashValue: Int { get }

        /// Creates a new instance by decoding from the given decoder.
        ///
        /// This initializer throws an error if reading from the decoder fails, or
        /// if the data read is corrupted or otherwise invalid.
        ///
        /// - Parameter decoder: The decoder to read data from.
        public init(from decoder: any Decoder) throws
    }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogSearchSuggestionsResponse : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogSearchSuggestionsResponse : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogSearchSuggestionsResponse.Suggestion : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// A protocol for music items that your app can fetch by
/// using a catalog search request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public protocol MusicCatalogSearchable : MusicItem {
}

/// A protocol for music items that your app can fetch by
/// using a catalog resource request without any filter.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public protocol MusicCatalogTopLevelResourceRequesting : MusicItem {
}

/// A request for loading data from an arbitrary Apple Music API endpoint.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct MusicDataRequest : Equatable, Hashable, Sendable {

    /// Creates a data request with a URL request.
    public init(urlRequest: URLRequest)

    /// The URL request for the data request.
    public let urlRequest: URLRequest

    /// Fetches data from the Apple Music API endpoint that
    /// the URL request defines.
    public func response() async throws -> MusicDataResponse

    /// Fetches the current country code for the user’s Apple Music account.
    ///
    /// The current country code may be useful to construct the URL for a
    /// ``MusicDataRequest`` because a typical catalog endpoint for
    /// Apple Music API requires the inclusion of a country code
    /// in the path of the corresponding URL.
    public static var currentCountryCode: String { get async throws }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicDataRequest, b: MusicDataRequest) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicDataRequest : CustomStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicDataRequest {

    /// The shared token provider for fetching tokens
    /// that Apple Music API requires.
    public static var tokenProvider: any MusicUserTokenProvider & MusicDeveloperTokenProvider
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicDataRequest {

    /// An error that the Apple Music API returns.
    public struct Error : Error, Sendable {

        /// The HTTP status code for the error.
        public let status: Int

        /// The specific code for the underlying cause of the error.
        public let code: Int

        /// A developer-friendly title for the error.
        public let title: String

        /// Additional detailed information about the cause of the error.
        ///
        /// This is to help identify possible resolutions.
        public let detailText: String

        /// The identifier for the error.
        public let id: String

        /// The source of the error.
        public let source: MusicDataRequest.Error.Source?

        /// The original response that contains the error.
        public let originalResponse: MusicDataResponse

        /// A representation of the source of an error from Apple Music API.
        public enum Source : Equatable, Sendable {

            /// The URI query parameter that causes the error.
            case parameter(String)

            /// Returns a Boolean value indicating whether two values are equal.
            ///
            /// Equality is the inverse of inequality. For any values `a` and `b`,
            /// `a == b` implies that `a != b` is `false`.
            ///
            /// - Parameters:
            ///   - lhs: A value to compare.
            ///   - rhs: Another value to compare.
            public static func == (a: MusicDataRequest.Error.Source, b: MusicDataRequest.Error.Source) -> Bool
        }
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicDataRequest.Error : CustomStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicDataRequest.Error.Source : CustomStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }
}

/// An object containing results for a data request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct MusicDataResponse : Equatable, Hashable, Sendable {

    /// The raw data returned by the Apple Music API endpoint
    /// for the originating data request.
    public let data: Data

    /// The URL response returned by the Apple Music API endpoint
    /// for the originating data request.
    public let urlResponse: HTTPURLResponse

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicDataResponse, b: MusicDataResponse) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicDataResponse : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// A set of methods that music requests use to access Apple Music API.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public protocol MusicDeveloperTokenProvider : Sendable {

    /// Fetches and returns a developer token for Apple Music API.
    ///
    /// If you opt to create a custom implementation of the
    /// ``MusicDeveloperTokenProvider`` protocol, make sure to discard
    /// any cached developer token if the `options` parameter contains
    /// ``MusicTokenRequestOptions/ignoreCache``.
    ///
    /// You can add the newly generated token to an in-memory or persistent
    /// cache for faster access upon subsequent requests for this token.
    func developerToken(options: MusicTokenRequestOptions) async throws -> String
}

/// An identifier for a music item extended attribute property
/// from a specific root type to a specific resulting value type.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public class MusicExtendedAttributeProperty<Root, Value> : PartialMusicAsyncProperty<Root>, CustomStringConvertible, @unchecked Sendable where Value : Decodable {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    @objc deinit
}

/// A protocol with basic requirements for music items.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public protocol MusicItem : Sendable {

    /// The unique identifier for the music item.
    var id: MusicItemID { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicItem where Self : MusicPropertyContainer, Self : Decodable {

    /// Loads a new instance of the music item that includes
    /// the specified properties.
    ///
    /// This asynchronous method fetches a more complete representation
    /// of the receiver from Apple Music API over the network.
    public func with(_ properties: [PartialMusicAsyncProperty<Self>]) async throws -> Self

    /// Loads a new instance of the music item that includes
    /// the specified properties.
    ///
    /// This asynchronous method fetches a more complete representation
    /// of the receiver, loading the contents for each property you request 
    /// from either the Apple Music catalog or the user’s library, depending 
    /// on the preferred source as well the availability of the content in those 
    /// respective data sources.
    ///
    /// For example, if you want to load the
    /// ``PartialMusicProperty/tracks-9mk2l`` relationship for
    /// an ``Album``, as found in the user’s library, as well as other
    /// associations of content that only live in the Apple Music catalog,
    /// like the ``PartialMusicProperty/recordLabels`` and
    /// ``PartialMusicProperty/relatedAlbums`` associations,
    /// you can use this code:
    /// 
    ///     let album: Album = …
    ///     let detailedAlbum = try await album.with(
    ///         [
    ///             .tracks,
    ///             .recordLabels,
    ///             .relatedAlbums
    ///         ],
    ///         preferredSource: .library
    ///     )
    /// 
    /// Here, because the ``PartialMusicProperty/tracks-9mk2l`` relationship
    /// for an ``Album`` is supported in both the library and the catalog,
    /// and because the this code specifically requests
    /// ``MusicPropertySource/library`` as the preferred source,
    /// the framework will load the tracks from the user’s library.
    /// However, because the ``PartialMusicProperty/recordLabels``
    /// and ``PartialMusicProperty/relatedAlbums`` associations are only
    /// available in the Apple Music catalog, the framework will also issue
    /// a network request to Apple Music API to fetch those associations
    /// of content from the catalog.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
    public func with(_ properties: [PartialMusicAsyncProperty<Self>], preferredSource: MusicPropertySource) async throws -> Self

    /// Loads a new instance of the music item that includes
    /// the specified properties.
    ///
    /// This asynchronous method fetches a more complete representation
    /// of the receiver, loading the contents for each property you request 
    /// from either the Apple Music catalog or the user’s library, depending 
    /// on the preferred source as well the availability of the content in those 
    /// respective data sources.
    ///
    /// For example, if you want to load the
    /// ``PartialMusicProperty/tracks-9mk2l`` relationship for
    /// an ``Album``, as found in the user’s library, as well as other
    /// associations of content that only live in the Apple Music catalog,
    /// like the ``PartialMusicProperty/recordLabels`` and
    /// ``PartialMusicProperty/relatedAlbums`` associations,
    /// you can use this code:
    /// 
    ///     let album: Album = …
    ///     let detailedAlbum = try await album.with(
    ///         .tracks,
    ///         .recordLabels,
    ///         .relatedAlbums, 
    ///         preferredSource: .library
    ///     )
    /// 
    /// Here, because the ``PartialMusicProperty/tracks-9mk2l`` relationship
    /// for an ``Album`` is supported in both the library and the catalog,
    /// and because the this code specifically requests
    /// ``MusicPropertySource/library`` as the preferred source,
    /// the framework will load the tracks from the user’s library.
    /// However, because the ``PartialMusicProperty/recordLabels``
    /// and ``PartialMusicProperty/relatedAlbums`` associations are only
    /// available in the Apple Music catalog, the framework will also issue
    /// a network request to Apple Music API to fetch those associations
    /// of content from the catalog.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
    public func with(_ properties: PartialMusicAsyncProperty<Self>..., preferredSource: MusicPropertySource) async throws -> Self
}

/// A collection of music items.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct MusicItemCollection<MusicItemType> where MusicItemType : MusicItem {

    /// An optional title for the collection.
    ///
    /// Collections that represent an association from a music item
    /// often contain a title.
    public var title: String? { get }

    /// Appends contents of a collection representing a next batch,
    /// in the right hand side, to the existing collection
    /// on the left hand side.
    ///
    /// In addition to appending the underlying items of the collection
    /// to the existing collection on the left hand side, this will also
    /// transfer to the collection on the left hand side any information
    /// about a next batch from the collection on the right hand side,
    /// or lack thereof.
    ///
    /// This appending operator is particularly useful for aggregating
    /// subsequent batches from a given collection into a local variable
    /// (for example, to use a ``MusicItemCollection`` to drive a SwiftUI
    /// <doc://com.apple.documentation/documentation/SwiftUI/List> or 
    /// <doc://com.apple.documentation/documentation/SwiftUI/ForEach>).
    public static func += (collection: inout MusicItemCollection<MusicItemType>, nextBatchCollection: MusicItemCollection<MusicItemType>)
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicItemCollection {

    /// A Boolean value that indicates whether the collection has information
    /// that allows it to fetch a subsequent batch of items.
    public var hasNextBatch: Bool { get }

    /// Fetches the next batch of items asynchronously.
    ///
    /// This method returns the next batch of items as another collection of
    /// music items of the same type.
    public func nextBatch(limit: Int? = nil) async throws -> MusicItemCollection<MusicItemType>?

    /// Fetches the next batch of items asynchronously.
    ///
    /// This method returns the next batch of items as another collection of
    /// music items of the same type.
    public func nextBatch(limit: Int? = nil) async throws -> MusicItemCollection<MusicItemType>? where MusicItemType : Decodable
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicItemCollection : ExpressibleByArrayLiteral {

    /// Creates an instance initialized with the given elements.
    public init(arrayLiteral items: MusicItemType...)

    /// The type of the elements of an array literal.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias ArrayLiteralElement = MusicItemType
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicItemCollection {

    public init<S>(_ elements: S) where MusicItemType == S.Element, S : Sequence
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicItemCollection : RandomAccessCollection {

    /// A type representing the sequence's elements.
    public typealias Element = MusicItemType

    /// A type that represents a position in the collection.
    ///
    /// Valid indices consist of the position of every element and a
    /// "past the end" position that's not valid for use as a subscript
    /// argument.
    public typealias Index = Array<MusicItemType>.Index

    /// A collection representing a contiguous subrange of this collection's
    /// elements. The subsequence shares indices with the original collection.
    ///
    /// The default subsequence type for collections that don't define their own
    /// is `Slice`.
    public typealias SubSequence = Array<MusicItemType>.SubSequence

    /// A type that represents the indices that are valid for subscripting the
    /// collection, in ascending order.
    public typealias Indices = Array<MusicItemType>.Indices

    /// The indices that are valid for subscripting the collection, in ascending
    /// order.
    ///
    /// A collection's `indices` property can hold a strong reference to the
    /// collection itself, causing the collection to be nonuniquely referenced.
    /// If you mutate the collection while iterating over its indices, a strong
    /// reference can result in an unexpected copy of the collection. To avoid
    /// the unexpected copy, use the `index(after:)` method starting with
    /// `startIndex` to produce indices instead.
    ///
    ///     var c = MyFancyCollection([10, 20, 30, 40, 50])
    ///     var i = c.startIndex
    ///     while i != c.endIndex {
    ///         c[i] /= 5
    ///         i = c.index(after: i)
    ///     }
    ///     // c == MyFancyCollection([2, 4, 6, 8, 10])
    public var indices: MusicItemCollection<MusicItemType>.Indices { get }

    /// Accesses a contiguous subrange of the collection's elements.
    ///
    /// The accessed slice uses the same indices for the same elements as the
    /// original collection uses. Always use the slice's `startIndex` property
    /// instead of assuming that its indices start at a particular value.
    ///
    /// This example demonstrates getting a slice of an array of strings, finding
    /// the index of one of the strings in the slice, and then using that index
    /// in the original array.
    ///
    ///     let streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
    ///     let streetsSlice = streets[2 ..< streets.endIndex]
    ///     print(streetsSlice)
    ///     // Prints "["Channing", "Douglas", "Evarts"]"
    ///
    ///     let index = streetsSlice.firstIndex(of: "Evarts")    // 4
    ///     print(streets[index!])
    ///     // Prints "Evarts"
    ///
    /// - Parameter bounds: A range of the collection's indices. The bounds of
    ///   the range must be valid indices of the collection.
    ///
    /// - Complexity: O(1)
    public subscript(bounds: Range<MusicItemCollection<MusicItemType>.Index>) -> MusicItemCollection<MusicItemType>.SubSequence { get }

    /// Accesses the element at the specified position.
    ///
    /// The following example accesses an element of an array through its
    /// subscript to print its value:
    ///
    ///     var streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
    ///     print(streets[1])
    ///     // Prints "Bryant"
    ///
    /// You can subscript a collection with any valid index other than the
    /// collection's end index. The end index refers to the position one past
    /// the last element of a collection, so it doesn't correspond with an
    /// element.
    ///
    /// - Parameter position: The position of the element to access. `position`
    ///   must be a valid index of the collection that is not equal to the
    ///   `endIndex` property.
    ///
    /// - Complexity: O(1)
    public subscript(position: MusicItemCollection<MusicItemType>.Index) -> MusicItemCollection<MusicItemType>.Element { get }

    /// The position of the first element in a nonempty collection.
    ///
    /// If the collection is empty, `startIndex` is equal to `endIndex`.
    public var startIndex: MusicItemCollection<MusicItemType>.Index { get }

    /// The collection's "past the end" position---that is, the position one
    /// greater than the last valid subscript argument.
    ///
    /// When you need a range that includes the last element of a collection, use
    /// the half-open range operator (`..<`) with `endIndex`. The `..<` operator
    /// creates a range that doesn't include the upper bound, so it's always
    /// safe to use with `endIndex`. For example:
    ///
    ///     let numbers = [10, 20, 30, 40, 50]
    ///     if let index = numbers.firstIndex(of: 30) {
    ///         print(numbers[index ..< numbers.endIndex])
    ///     }
    ///     // Prints "[30, 40, 50]"
    ///
    /// If the collection is empty, `endIndex` is equal to `startIndex`.
    public var endIndex: MusicItemCollection<MusicItemType>.Index { get }

    /// Returns the position immediately before the given index.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be greater than
    ///   `startIndex`.
    /// - Returns: The index value immediately before `i`.
    public func index(before i: MusicItemCollection<MusicItemType>.Index) -> MusicItemCollection<MusicItemType>.Index

    /// Replaces the given index with its predecessor.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be greater than
    ///   `startIndex`.
    public func formIndex(before i: inout MusicItemCollection<MusicItemType>.Index)

    /// Returns the position immediately after the given index.
    ///
    /// The successor of an index must be well defined. For an index `i` into a
    /// collection `c`, calling `c.index(after: i)` returns the same index every
    /// time.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    /// - Returns: The index value immediately after `i`.
    public func index(after i: MusicItemCollection<MusicItemType>.Index) -> MusicItemCollection<MusicItemType>.Index

    /// Replaces the given index with its successor.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    public func formIndex(after i: inout MusicItemCollection<MusicItemType>.Index)

    /// Returns an index that is the specified distance from the given index.
    ///
    /// The following example obtains an index advanced four positions from a
    /// string's starting index and then prints the character at that position.
    ///
    ///     let s = "Swift"
    ///     let i = s.index(s.startIndex, offsetBy: 4)
    ///     print(s[i])
    ///     // Prints "t"
    ///
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset `i`. `distance` must not be negative
    ///     unless the collection conforms to the `BidirectionalCollection`
    ///     protocol.
    /// - Returns: An index offset by `distance` from the index `i`. If
    ///   `distance` is positive, this is the same value as the result of
    ///   `distance` calls to `index(after:)`. If `distance` is negative, this
    ///   is the same value as the result of `abs(distance)` calls to
    ///   `index(before:)`.
    ///
    /// - Complexity: O(1)
    public func index(_ i: MusicItemCollection<MusicItemType>.Index, offsetBy distance: Int) -> MusicItemCollection<MusicItemType>.Index

    /// Returns an index that is the specified distance from the given index,
    /// unless that distance is beyond a given limiting index.
    ///
    /// The following example obtains an index advanced four positions from a
    /// string's starting index and then prints the character at that position.
    /// The operation doesn't require going beyond the limiting `s.endIndex`
    /// value, so it succeeds.
    ///
    ///     let s = "Swift"
    ///     if let i = s.index(s.startIndex, offsetBy: 4, limitedBy: s.endIndex) {
    ///         print(s[i])
    ///     }
    ///     // Prints "t"
    ///
    /// The next example attempts to retrieve an index six positions from
    /// `s.startIndex` but fails, because that distance is beyond the index
    /// passed as `limit`.
    ///
    ///     let j = s.index(s.startIndex, offsetBy: 6, limitedBy: s.endIndex)
    ///     print(j)
    ///     // Prints "nil"
    ///
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection, unless the index passed as `limit` prevents offsetting
    /// beyond those bounds.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - distance: The distance to offset `i`. `distance` must not be negative
    ///     unless the collection conforms to the `BidirectionalCollection`
    ///     protocol.
    ///   - limit: A valid index of the collection to use as a limit. If
    ///     `distance > 0`, a limit that is less than `i` has no effect.
    ///     Likewise, if `distance < 0`, a limit that is greater than `i` has no
    ///     effect.
    /// - Returns: An index offset by `distance` from the index `i`, unless that
    ///   index would be beyond `limit` in the direction of movement. In that
    ///   case, the method returns `nil`.
    ///
    /// - Complexity: O(1)
    public func index(_ i: MusicItemCollection<MusicItemType>.Index, offsetBy distance: Int, limitedBy limit: MusicItemCollection<MusicItemType>.Index) -> MusicItemCollection<MusicItemType>.Index?

    /// Returns the distance between two indices.
    ///
    /// Unless the collection conforms to the `BidirectionalCollection` protocol,
    /// `start` must be less than or equal to `end`.
    ///
    /// - Parameters:
    ///   - start: A valid index of the collection.
    ///   - end: Another valid index of the collection. If `end` is equal to
    ///     `start`, the result is zero.
    /// - Returns: The distance between `start` and `end`. The result can be
    ///   negative only if the collection conforms to the
    ///   `BidirectionalCollection` protocol.
    ///
    /// - Complexity: O(1)
    public func distance(from start: MusicItemCollection<MusicItemType>.Index, to end: MusicItemCollection<MusicItemType>.Index) -> Int

    /// A type that provides the collection's iteration interface and
    /// encapsulates its iteration state.
    ///
    /// By default, a collection conforms to the `Sequence` protocol by
    /// supplying `IndexingIterator` as its associated `Iterator`
    /// type.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias Iterator = IndexingIterator<MusicItemCollection<MusicItemType>>
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicItemCollection : Equatable where MusicItemType : Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (left: MusicItemCollection<MusicItemType>, right: MusicItemCollection<MusicItemType>) -> Bool
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicItemCollection : Hashable where MusicItemType : Hashable {

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicItemCollection : Sendable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicItemCollection : Decodable where MusicItemType : Decodable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicItemCollection : Encodable where MusicItemType : Encodable {

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicItemCollection : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// An object that represents a unique identifier for a music item.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
@frozen public struct MusicItemID : Equatable, Hashable, Sendable, RawRepresentable, ExpressibleByStringLiteral {

    /// Creates a music item identifier with a string.
    public init(_ rawValue: String)

    /// Creates a new instance with the specified raw value.
    ///
    /// If there is no value of the type that corresponds with the specified raw
    /// value, this initializer returns `nil`. For example:
    ///
    ///     enum PaperSize: String {
    ///         case A4, A5, Letter, Legal
    ///     }
    ///
    ///     print(PaperSize(rawValue: "Legal"))
    ///     // Prints "Optional(PaperSize.Legal)"
    ///
    ///     print(PaperSize(rawValue: "Tabloid"))
    ///     // Prints "nil"
    ///
    /// - Parameter rawValue: The raw value to use for the new instance.
    public init(rawValue: String)

    /// Creates an instance initialized to the given string value.
    ///
    /// - Parameter value: The value of the new instance.
    public init(stringLiteral value: String)

    /// The corresponding value of the raw type.
    ///
    /// A new instance initialized with `rawValue` will be equivalent to this
    /// instance. For example:
    ///
    ///     enum PaperSize: String {
    ///         case A4, A5, Letter, Legal
    ///     }
    ///
    ///     let selectedSize = PaperSize.Letter
    ///     print(selectedSize.rawValue)
    ///     // Prints "Letter"
    ///
    ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
    ///     // Prints "true"
    public let rawValue: String

    /// A type that represents an extended grapheme cluster literal.
    ///
    /// Valid types for `ExtendedGraphemeClusterLiteralType` are `Character`,
    /// `String`, and `StaticString`.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias ExtendedGraphemeClusterLiteralType = String

    /// The raw type that can be used to represent all values of the conforming
    /// type.
    ///
    /// Every distinct value of the conforming type has a corresponding unique
    /// value of the `RawValue` type, but there may be values of the `RawValue`
    /// type that don't have a corresponding value of the conforming type.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias RawValue = String

    /// A type that represents a string literal.
    ///
    /// Valid types for `StringLiteralType` are `String` and `StaticString`.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias StringLiteralType = String

    /// A type that represents a Unicode scalar literal.
    ///
    /// Valid types for `UnicodeScalarLiteralType` are `Unicode.Scalar`,
    /// `Character`, `String`, and `StaticString`.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias UnicodeScalarLiteralType = String
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicItemID : MusicLibraryRequestFilterValueEquatable {
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicItemID : MusicLibraryRequestFilterValueMembershipComparable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicItemID : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicItemID : CustomStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }
}

/// An object your app uses to access the user’s music library.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public class MusicLibrary {

    /// A shared object that allows your app to modify the user’s music library.
    public static let shared: MusicLibrary

    @objc deinit

    /// Adds an item to the user’s music library.
    @available(macOS, unavailable)
    @available(macCatalyst, unavailable)
    public func add<MusicItemType>(_ item: MusicItemType) async throws where MusicItemType : MusicLibraryAddable

    /// Adds an item to the end of an existing playlist.
    ///
    /// - Returns: The updated playlist.
    @available(macOS, unavailable)
    @available(macCatalyst, unavailable)
    @discardableResult
    public func add<MusicItemType>(_ item: MusicItemType, to playlist: Playlist) async throws -> Playlist where MusicItemType : MusicPlaylistAddable

    /// Creates a playlist in the user’s music library.
    ///
    /// - Parameters:
    ///   - name: The name of the playlist.
    ///   - description: An optional description of the playlist.
    ///   - authorDisplayName: The display name of the author for the playlist.
    ///     A `nil` value will result in the framework using
    ///     your app’s name instead.
    /// - Returns: The newly created playlist.
    @available(macOS, unavailable)
    @available(macCatalyst, unavailable)
    @discardableResult
    public func createPlaylist(name: String, description: String? = nil, authorDisplayName: String? = nil) async throws -> Playlist

    /// Creates a playlist in the user’s music library.
    ///
    /// - Parameters:
    ///   - name: The name of the playlist.
    ///   - description: An optional description of the playlist.
    ///   - authorDisplayName: The display name of the author for the playlist.
    ///     A `nil` value will result in the framework using
    ///     your app’s name instead.
    ///   - items: The items of the playlist.
    /// - Returns: The newly created playlist.
    @available(macOS, unavailable)
    @available(macCatalyst, unavailable)
    @discardableResult
    public func createPlaylist<S, MusicPlaylistAddableType>(name: String, description: String? = nil, authorDisplayName: String? = nil, items: S) async throws -> Playlist where S : Sequence, MusicPlaylistAddableType : MusicPlaylistAddable, MusicPlaylistAddableType == S.Element

    /// Edits a playlist that your app has created.
    ///
    /// This function will throw an error if your app attempts to edit
    /// a playlist that another app created.
    /// - Returns: The edited playlist.
    @available(macOS, unavailable)
    @available(macCatalyst, unavailable)
    @discardableResult
    public func edit(_ playlist: Playlist, name: String? = nil, description: String? = nil, authorDisplayName: String? = nil) async throws -> Playlist

    /// Edits a playlist that your app has created including items
    /// to rebuild the list of entries.
    ///
    /// This function will throw an error if your app attempts to edit
    /// a playlist that another app created.
    /// - Returns: The edited playlist.
    @available(macOS, unavailable)
    @available(macCatalyst, unavailable)
    @discardableResult
    public func edit<S, MusicPlaylistAddableType>(_ playlist: Playlist, name: String? = nil, description: String? = nil, authorDisplayName: String? = nil, items: S) async throws -> Playlist where S : Sequence, MusicPlaylistAddableType : MusicPlaylistAddable, MusicPlaylistAddableType == S.Element
}

@available(iOS 16.1, tvOS 16.1, watchOS 9.1, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibrary {

    /// An error that the music library can throw upon accessing, manipulating, or requesting data from the user’s music library.
    public enum Error : String, LocalizedError, Sendable, CustomStringConvertible {

        /// An error indicating the ocurrence of an unknown or unexpected error.
        case unknown

        /// An error that occurs when the user doesn’t consent for the
        /// current app to access their Apple Music library.
        ///
        /// Apps using MusicKit need to request prior informed consent
        /// from the user to access their Apple Music library by calling
        /// ``MusicAuthorization/request()`` at the appropriate point in the
        /// app flow, right before needing to use other APIs from MusicKit.
        case permissionDenied

        /// An error indicating that the item attempting to be added
        /// to the user’s music library cannot be added.
        case unableToAddItem

        /// An error indicating that the item attempting to be added
        /// to the user’s music library is already in the library.
        case itemAlreadyAdded

        /// An error indicating that the playlist attempting to be
        /// added to is not in the user’s library.
        case playlistNotInLibrary

        /// An error that indicates a failure in the process of
        /// adding an item to a playlist.
        case addToPlaylistFailed

        /// An error that indicates a failure in the process of
        /// creating a playlist.
        case createPlaylistFailed

        /// An error that indicates a failure in the process of
        /// editing a playlist.
        case editPlaylistFailed

        /// A localized message describing what error occurred.
        public var errorDescription: String? { get }

        /// A localized message describing the reason for the failure.
        public var failureReason: String? { get }

        /// A localized message describing how one might recover from the failure.
        public var recoverySuggestion: String? { get }

        /// A localized message providing "help" text if the user requests help.
        public var helpAnchor: String? { get }

        /// A textual representation of this instance.
        ///
        /// Calling this property directly is discouraged. Instead, convert an
        /// instance of any type to a string by using the `String(describing:)`
        /// initializer. This initializer works with any type, and uses the custom
        /// `description` property for types that conform to
        /// `CustomStringConvertible`:
        ///
        ///     struct Point: CustomStringConvertible {
        ///         let x: Int, y: Int
        ///
        ///         var description: String {
        ///             return "(\(x), \(y))"
        ///         }
        ///     }
        ///
        ///     let p = Point(x: 21, y: 30)
        ///     let s = String(describing: p)
        ///     print(s)
        ///     // Prints "(21, 30)"
        ///
        /// The conversion of `p` to a string in the assignment to `s` uses the
        /// `Point` type's `description` property.
        public var description: String { get }

        /// Creates a new instance with the specified raw value.
        ///
        /// If there is no value of the type that corresponds with the specified raw
        /// value, this initializer returns `nil`. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     print(PaperSize(rawValue: "Legal"))
        ///     // Prints "Optional(PaperSize.Legal)"
        ///
        ///     print(PaperSize(rawValue: "Tabloid"))
        ///     // Prints "nil"
        ///
        /// - Parameter rawValue: The raw value to use for the new instance.
        public init?(rawValue: String)

        /// The raw type that can be used to represent all values of the conforming
        /// type.
        ///
        /// Every distinct value of the conforming type has a corresponding unique
        /// value of the `RawValue` type, but there may be values of the `RawValue`
        /// type that don't have a corresponding value of the conforming type.
        @available(iOS 16.1, tvOS 16.1, watchOS 9.1, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
        public typealias RawValue = String

        /// The corresponding value of the raw type.
        ///
        /// A new instance initialized with `rawValue` will be equivalent to this
        /// instance. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     let selectedSize = PaperSize.Letter
        ///     print(selectedSize.rawValue)
        ///     // Prints "Letter"
        ///
        ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
        ///     // Prints "true"
        public var rawValue: String { get }
    }
}

@available(iOS 16.1, tvOS 16.1, watchOS 9.1, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibrary.Error : Equatable {
}

@available(iOS 16.1, tvOS 16.1, watchOS 9.1, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibrary.Error : Hashable {
}

@available(iOS 16.1, tvOS 16.1, watchOS 9.1, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibrary.Error : RawRepresentable {
}

/// A protocol for music items that your app can add to the music library.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
public protocol MusicLibraryAddable : MusicItem {
}

/// A request that your app uses to fetch items from the user’s music library.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public struct MusicLibraryRequest<MusicItemType> where MusicItemType : MusicLibraryRequestable {

    /// Creates a request to fetch items from the library.
    public init()

    /// A limit for the number of items to return in the library response.
    ///
    /// A limit of 0 length means no limit.
    public var limit: Int

    /// An offset for the request.
    public var offset: Int

    /// A Boolean value that indicates whether the library response
    /// should only include items downloaded on the user’s device.
    public var includeOnlyDownloadedContent: Bool

    /// Filters items by a given relationship that matches a specific value.
    public mutating func filter<RelatedMusicItemType>(matching keyPath: KeyPath<MusicItemType.LibraryFilter, MusicItemCollection<RelatedMusicItemType>?>, contains relatedItem: RelatedMusicItemType) where RelatedMusicItemType : MusicItem

    /// Filters items by a given property that contains a specific string.
    public mutating func filter(matching keyPath: KeyPath<MusicItemType.LibraryFilter, String>, contains text: String)

    /// Filters items by a given optional property that contains a specific string.
    public mutating func filter(matching keyPath: KeyPath<MusicItemType.LibraryFilter, String?>, contains text: String)

    /// Filters items by a given property that matches a specific value.
    public mutating func filter<Value>(matching keyPath: KeyPath<MusicItemType.LibraryFilter, Value>, equalTo value: Value) where Value : MusicLibraryRequestFilterValueEquatable

    /// Filters items by a given optional property that matches a specific value.
    public mutating func filter<Value>(matching keyPath: KeyPath<MusicItemType.LibraryFilter, Value?>, equalTo value: Value?) where Value : MusicLibraryRequestFilterValueEquatable

    /// Filters items by a property for an array of possible values.
    public mutating func filter<Value>(matching keyPath: KeyPath<MusicItemType.LibraryFilter, Value>, memberOf values: [Value]) where Value : MusicLibraryRequestFilterValueMembershipComparable

    /// Filters items by an optional property for an array of possible values.
    public mutating func filter<Value>(matching keyPath: KeyPath<MusicItemType.LibraryFilter, Value?>, memberOf values: [Value?]) where Value : MusicLibraryRequestFilterValueMembershipComparable

    /// Filters items by a specific string.
    public mutating func filter(text: String)

    /// Sorts items by a specified property.
    public mutating func sort<Value>(by keyPath: KeyPath<MusicItemType.LibrarySortProperties, Value>, ascending: Bool)

    /// Fetches items from the user’s music library.
    public func response() async throws -> MusicLibraryResponse<MusicItemType>
}

/// A protocol for types of values your app can use with equality
/// filters when fetching items using a music library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol MusicLibraryRequestFilterValueEquatable {
}

/// A protocol for types of values your app can use with membership
/// filters when fetching items using a music library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol MusicLibraryRequestFilterValueMembershipComparable {
}

/// A protocol for music items that your app can fetch
/// by using a library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol MusicLibraryRequestable : MusicItem {

    /// The associated type that contains the set of music item properties
    /// your app uses as a filter for a library request.
    associatedtype LibraryFilter

    /// The associated type that contains the set of properties
    /// your app uses to sort results for a library request.
    associatedtype LibrarySortProperties
}

/// An object that contains results for a library request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public struct MusicLibraryResponse<MusicItemType> where MusicItemType : MusicItem {

    /// A collection of items that match the filters on the originating library request.
    public let items: MusicItemCollection<MusicItemType>
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibraryResponse : Equatable where MusicItemType : Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicLibraryResponse<MusicItemType>, b: MusicLibraryResponse<MusicItemType>) -> Bool
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibraryResponse : Hashable where MusicItemType : Hashable {

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibraryResponse : Sendable {
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibraryResponse : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// A request that your app uses to fetch items from user’s library
/// using a search term.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public struct MusicLibrarySearchRequest : Equatable, Hashable, Sendable {

    /// Creates a library search request for a specified search term
    /// and list of library searchable types.
    public init(term: String, types: [any MusicLibrarySearchable.Type])

    /// The search term for the request.
    public let term: String

    /// The list of requested library searchable types.
    public var types: [any MusicLibrarySearchable.Type] { get }

    /// A Boolean value that indicates whether to request top search results.
    public var includeTopResults: Bool

    /// A limit for the number of items to return
    /// in the library search response.
    ///
    /// The default value for this limit is 50.
    ///
    /// If the application sets the limit to 0, the framework returns
    /// all matching items in the user’s music library.
    public var limit: Int

    /// Fetches items of the requested library searchable types that match
    /// the search term of the request.
    public func response() async throws -> MusicLibrarySearchResponse

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicLibrarySearchRequest, b: MusicLibrarySearchRequest) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

/// An object that contains results for a library search request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public struct MusicLibrarySearchResponse : Equatable, Hashable, Sendable {

    /// A collection of albums.
    public let albums: MusicItemCollection<Album>

    /// A collection of artists.
    public let artists: MusicItemCollection<Artist>

    /// A collection of music videos.
    public let musicVideos: MusicItemCollection<MusicVideo>

    /// A collection of playlists.
    public let playlists: MusicItemCollection<Playlist>

    /// A collection of songs.
    public let songs: MusicItemCollection<Song>

    /// A collection of top results.
    public let topResults: MusicItemCollection<MusicLibrarySearchResponse.TopResult>

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicLibrarySearchResponse, b: MusicLibrarySearchResponse) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibrarySearchResponse : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibrarySearchResponse {

    /// An item that represents one of the top results in a library search response.
    public enum TopResult : MusicItem, Equatable, Hashable, Identifiable, Sendable {

        /// An item that corresponds to an album.
        case album(Album)

        /// An item that corresponds to an artist.
        case artist(Artist)

        /// An item that corresponds to a music video.
        case musicVideo(MusicVideo)

        /// An item that corresponds to a playlist.
        case playlist(Playlist)

        /// An item that corresponds to a song.
        case song(Song)

        /// The unique identifier of this item.
        public var id: MusicItemID { get }

        /// The artwork of this top result for library search.
        public var artwork: Artwork? { get }

        /// The title of this top result for library search.
        public var title: String { get }

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: MusicLibrarySearchResponse.TopResult, b: MusicLibrarySearchResponse.TopResult) -> Bool

        /// A type representing the stable identity of the entity associated with
        /// an instance.
        @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
        public typealias ID = MusicItemID

        /// Hashes the essential components of this value by feeding them into the
        /// given hasher.
        ///
        /// Implement this method to conform to the `Hashable` protocol. The
        /// components used for hashing must be the same as the components compared
        /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
        /// with each of these components.
        ///
        /// - Important: In your implementation of `hash(into:)`,
        ///   don't call `finalize()` on the `hasher` instance provided,
        ///   or replace it with a different instance.
        ///   Doing so may become a compile-time error in the future.
        ///
        /// - Parameter hasher: The hasher to use when combining the components
        ///   of this instance.
        public func hash(into hasher: inout Hasher)

        /// The hash value.
        ///
        /// Hash values are not guaranteed to be equal across different executions of
        /// your program. Do not save hash values to use during a future execution.
        ///
        /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
        ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
        ///   The compiler provides an implementation for `hashValue` for you.
        public var hashValue: Int { get }
    }
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibrarySearchResponse.TopResult : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibrarySearchResponse.TopResult : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// A protocol for music items that your app can fetch by
/// using a library search request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol MusicLibrarySearchable : MusicItem {
}

/// A section for a library sectioned response.
///
/// Your app can access any property of the requested section type directly
/// on this library section object.
///
/// Your app can also access the items contained in a library section with
/// the ``items`` property.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
@dynamicMemberLookup public struct MusicLibrarySection<SectionType, MusicItemType> where SectionType : MusicLibrarySectionRequestable, MusicItemType : MusicLibraryRequestable {

    /// A collection of items that correspond to the children of the section.
    public let items: MusicItemCollection<MusicItemType>

    /// A subscript that allows your app to access any property
    /// of the requested section type directly on this library section object.
    public subscript<T>(dynamicMember keyPath: KeyPath<SectionType, T>) -> T { get }
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibrarySection : Identifiable {

    /// The stable identity of the entity associated with this instance.
    public var id: MusicItemID { get }

    /// A type representing the stable identity of the entity associated with
    /// an instance.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
    public typealias ID = MusicItemID
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibrarySection : Equatable where SectionType : Equatable, MusicItemType : Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicLibrarySection<SectionType, MusicItemType>, b: MusicLibrarySection<SectionType, MusicItemType>) -> Bool
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibrarySection : Hashable where SectionType : Hashable, MusicItemType : Hashable {

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibrarySection : Sendable where SectionType : Sendable {
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibrarySection : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// A protocol for types your app uses as sections
/// when fetching items using a library sectioned request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public protocol MusicLibrarySectionRequestable {
}

/// A request that your app uses to fetch items grouped by sections
/// from the user’s music library.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public struct MusicLibrarySectionedRequest<SectionType, MusicItemType> where SectionType : MusicLibrarySectionRequestable, MusicItemType : MusicLibraryRequestable {

    /// Creates a request to fetch items grouped by sections from the library.
    public init()

    /// A limit for the number of items to return in the library response.
    ///
    /// A limit of 0 length means no limit.
    public var limit: Int

    /// An offset for the request.
    public var offset: Int

    /// A Boolean value that indicates whether the library response
    /// should only include items downloaded on the user’s device.
    public var includeOnlyDownloadedContent: Bool

    /// Filters items by a given relationship that matches a specific value.
    public mutating func filterItems<RelatedMusicItemType>(matching keyPath: KeyPath<MusicItemType.LibraryFilter, MusicItemCollection<RelatedMusicItemType>?>, contains relatedItem: RelatedMusicItemType) where RelatedMusicItemType : MusicItem

    /// Filters items by a given property that contains a specific string.
    @available(macOS, unavailable)
    @available(macCatalyst, unavailable)
    public mutating func filterItems(matching keyPath: KeyPath<MusicItemType.LibraryFilter, String>, contains text: String)

    /// Filters items by a given optional property that contains a specific string.
    @available(macOS, unavailable)
    @available(macCatalyst, unavailable)
    public mutating func filterItems(matching keyPath: KeyPath<MusicItemType.LibraryFilter, String?>, contains text: String)

    /// Filters items by a given property that matches a specific value.
    public mutating func filterItems<Value>(matching keyPath: KeyPath<MusicItemType.LibraryFilter, Value>, equalTo value: Value) where Value : MusicLibraryRequestFilterValueEquatable

    /// Filters items by a given optional property that matches a specific value.
    public mutating func filterItems<Value>(matching keyPath: KeyPath<MusicItemType.LibraryFilter, Value?>, equalTo value: Value?) where Value : MusicLibraryRequestFilterValueEquatable

    /// Filters items by a property for an array of possible values.
    public mutating func filterItems<Value>(matching keyPath: KeyPath<MusicItemType.LibraryFilter, Value>, memberOf values: [Value]) where Value : MusicLibraryRequestFilterValueMembershipComparable

    /// Filters items by an optional property for an array of possible values.
    public mutating func filterItems<Value>(matching keyPath: KeyPath<MusicItemType.LibraryFilter, Value?>, memberOf values: [Value?]) where Value : MusicLibraryRequestFilterValueMembershipComparable

    /// Filters items by a specific string.
    public mutating func filterItems(text: String)

    /// Sorts items by a specified property.
    public mutating func sortItems<Value>(by keyPath: KeyPath<MusicItemType.LibrarySortProperties, Value>, ascending: Bool)

    /// Filters sections by a given property that contains a specific string.
    public mutating func filterSections(matching keyPath: KeyPath<SectionType.LibraryFilter, String>, contains text: String) where SectionType : MusicLibraryRequestable

    /// Filters sections by a given optional property that contains a specific string.
    public mutating func filterSections(matching keyPath: KeyPath<SectionType.LibraryFilter, String?>, contains text: String) where SectionType : MusicLibraryRequestable

    /// Filters sections by a given property that matches a specific value.
    public mutating func filterSections<Value>(matching keyPath: KeyPath<SectionType.LibraryFilter, Value>, equalTo value: Value) where SectionType : MusicLibraryRequestable, Value : MusicLibraryRequestFilterValueEquatable

    /// Filters sections by a given optional property that matches a specific value.
    public mutating func filterSections<Value>(matching keyPath: KeyPath<SectionType.LibraryFilter, Value?>, equalTo value: Value?) where SectionType : MusicLibraryRequestable, Value : MusicLibraryRequestFilterValueEquatable

    /// Filters sections by a property for an array of possible values.
    public mutating func filterSections<Value>(matching keyPath: KeyPath<SectionType.LibraryFilter, Value>, memberOf values: [Value]) where SectionType : MusicLibraryRequestable, Value : MusicLibraryRequestFilterValueMembershipComparable

    /// Filters sections by an optional property for an array of possible values.
    public mutating func filterSections<Value>(matching keyPath: KeyPath<SectionType.LibraryFilter, Value?>, memberOf values: [Value?]) where SectionType : MusicLibraryRequestable, Value : MusicLibraryRequestFilterValueMembershipComparable

    /// Filters sections by a specific string.
    public mutating func filterSections(text: String) where SectionType : MusicLibraryRequestable

    /// Sorts sections by a specified property.
    public mutating func sortSections<Value>(by keyPath: KeyPath<SectionType.LibrarySortProperties, Value>, ascending: Bool) where SectionType : MusicLibraryRequestable

    /// Fetches items grouped by sections from the user’s music library.
    public func response() async throws -> MusicLibrarySectionedResponse<SectionType, MusicItemType>
}

/// An object that contains results for a library sectioned request.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public struct MusicLibrarySectionedResponse<SectionType, MusicItemType> where SectionType : MusicLibrarySectionRequestable, MusicItemType : MusicLibraryRequestable {

    /// An array of sections that match the filters on the originating library request.
    public let sections: [MusicLibrarySection<SectionType, MusicItemType>]
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibrarySectionedResponse : Equatable where SectionType : Equatable, MusicItemType : Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicLibrarySectionedResponse<SectionType, MusicItemType>, b: MusicLibrarySectionedResponse<SectionType, MusicItemType>) -> Bool
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibrarySectionedResponse : Hashable where SectionType : Hashable, MusicItemType : Hashable {

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibrarySectionedResponse : Sendable where SectionType : Sendable {
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicLibrarySectionedResponse : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// An object that contains recommended items based on the user’s library
/// and listening history.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public struct MusicPersonalRecommendation : MusicItem, Equatable, Hashable, Identifiable, Sendable {

    /// The unique identifier for the personal recommendation.
    public let id: MusicItemID

    /// The title for the personal recommendation.
    public let title: String?

    /// The reason for the personal recommendation.
    public let reason: String?

    /// The next date for refreshing the personal recommendation.
    public let nextRefreshDate: Date?

    /// The types of items in the personal recommendation.
    public var types: [any MusicPersonalRecommendationItem.Type] { get }

    /// The albums for the personal recommendation.
    public var albums: MusicItemCollection<Album> { get }

    /// The playlists for the personal recommendation.
    public var playlists: MusicItemCollection<Playlist> { get }

    /// The stations for the personal recommendation.
    public var stations: MusicItemCollection<Station> { get }

    /// The items for the personal recommendation.
    public var items: MusicItemCollection<MusicPersonalRecommendation.Item> { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicPersonalRecommendation, b: MusicPersonalRecommendation) -> Bool

    /// A type representing the stable identity of the entity associated with
    /// an instance.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 13.0, *)
    public typealias ID = MusicItemID

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicPersonalRecommendation : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicPersonalRecommendation : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicPersonalRecommendation {

    /// An item that represents an album, a playlist, or a station
    /// for a personal recommendation.
    public enum Item : MusicItem, Equatable, Hashable, Identifiable, Sendable {

        /// An item that corresponds to an album.
        case album(Album)

        /// An item that corresponds to a playlist.
        case playlist(Playlist)

        /// An item that corresponds to a station.
        case station(Station)

        /// The unique identifier of this item.
        public var id: MusicItemID { get }

        /// The artwork of this item.
        public var artwork: Artwork? { get }

        /// The title of this item.
        public var title: String { get }

        /// The subtitle of this item.
        public var subtitle: String? { get }

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: MusicPersonalRecommendation.Item, b: MusicPersonalRecommendation.Item) -> Bool

        /// A type representing the stable identity of the entity associated with
        /// an instance.
        @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 13.0, *)
        public typealias ID = MusicItemID

        /// Hashes the essential components of this value by feeding them into the
        /// given hasher.
        ///
        /// Implement this method to conform to the `Hashable` protocol. The
        /// components used for hashing must be the same as the components compared
        /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
        /// with each of these components.
        ///
        /// - Important: In your implementation of `hash(into:)`,
        ///   don't call `finalize()` on the `hasher` instance provided,
        ///   or replace it with a different instance.
        ///   Doing so may become a compile-time error in the future.
        ///
        /// - Parameter hasher: The hasher to use when combining the components
        ///   of this instance.
        public func hash(into hasher: inout Hasher)

        /// The hash value.
        ///
        /// Hash values are not guaranteed to be equal across different executions of
        /// your program. Do not save hash values to use during a future execution.
        ///
        /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
        ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
        ///   The compiler provides an implementation for `hashValue` for you.
        public var hashValue: Int { get }
    }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicPersonalRecommendation.Item : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicPersonalRecommendation.Item : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// A protocol for music items that your app can fetch by
/// using a personal recommendations request.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public protocol MusicPersonalRecommendationItem : MusicItem {
}

/// A request that your app uses to fetch music recommendations
/// based on the user’s library and listening history.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public struct MusicPersonalRecommendationsRequest : Equatable, Hashable, Sendable {

    /// Creates a request to fetch default personal recommendations
    /// for the user.
    public init()

    /// Creates a request to fetch default personal recommendations
    /// for the user.
    public init<S>(refreshing recommendations: S) where S : Sequence, S.Element == MusicPersonalRecommendation

    /// A limit for the number of recommendations to return
    /// in the personal recommendations response.
    public var limit: Int?

    /// An offet for the request.
    public var offset: Int?

    /// Fetches the music recommendations based on the user’s library
    /// and listening history.
    public func response() async throws -> MusicPersonalRecommendationsResponse

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicPersonalRecommendationsRequest, b: MusicPersonalRecommendationsRequest) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

/// An object that contains results for a personal recommendations request.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public struct MusicPersonalRecommendationsResponse : Equatable, Hashable, Sendable {

    /// A collection of personal recommendations.
    public let recommendations: MusicItemCollection<MusicPersonalRecommendation>

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicPersonalRecommendationsResponse, b: MusicPersonalRecommendationsResponse) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicPersonalRecommendationsResponse : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicPersonalRecommendationsResponse : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// An object your app uses to play music.
@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
public class MusicPlayer {

    /// An object that exposes the observable properties of the music player.
    final public let state: MusicPlayer.State

    /// A Boolean value that indicates whether a music player is ready to play.
    public var isPreparedToPlay: Bool { get }

    /// Prepares the current queue for playback, interrupting any active
    /// (nonmixable) audio sessions.
    ///
    /// Call this function to ensure that the player buffers
    /// the starting entry in the queue and that the entry is ready to play.
    public func prepareToPlay() async throws

    /// Initiates playback from the current queue.
    ///
    /// If playback isn’t underway, this method resumes playback from
    /// its paused location; otherwise, this method plays the first available
    /// entry from the beginning.
    ///
    /// If a music player isn’t ready for playback when you call this
    /// method, this method prepares the music player and then
    /// starts playback.
    public func play() async throws

    /// Pauses playback of the current entry.
    ///
    /// If playback isn’t currently underway, this method has no effect.
    /// To resume playback of the current entry from the pause point,
    /// call the ``play()`` method.
    public func pause()

    /// Ends playback of the current entry.
    public func stop()

    /// The current playback time, in seconds, of the current entry.
    ///
    /// Changing the value of this property moves the playhead to the
    /// new location. For content streaming live from a server,
    /// this value represents the time from the beginning of the playlist
    /// when it first loads. This property returns `NaN` if the
    /// <doc://com.apple.documentation/documentation/CoreMedia/CMTime>
    /// is invalid or indefinite.
    public var playbackTime: TimeInterval

    /// Begins seeking forward through the music content.
    ///
    /// Use this method to move the current playback position forward
    /// in time at an accelerated rate. Seeking begins when you call
    /// this method, and continues until you call the ``endSeeking()`` method.
    ///
    /// If the player is streaming the underlying content,
    /// this method has no effect.
    public func beginSeekingForward()

    /// Begins seeking backward through the music content.
    ///
    /// Use this method to move the current playback position backward
    /// in time at an accelerated rate. Seeking begins when you call
    /// this method, and continues until you call the ``endSeeking()`` method.
    ///
    /// If the player is streaming the underlying content,
    /// this method has no effect.
    public func beginSeekingBackward()

    /// Ends forward and backward seeking through the music content.
    ///
    /// Call this method to end a seek operation that begins when you call
    /// either the ``beginSeekingBackward()`` or ``beginSeekingForward()``
    /// method.
    /// After calling this method, the player returns to its previous state.
    /// For example, if the entry is playing before seeking begins, 
    /// it continues playing from the new playhead position after calling
    /// this method.
    public func endSeeking()

    /// Starts playback of the next entry in the playback queue.
    /// 
    /// If the music player isn’t playing, this method designates
    /// the next entry as the next to play.
    ///
    /// When you call this method, playback ends if the music player is
    /// already at the last entry in the playback queue.
    public func skipToNextEntry() async throws

    /// Restarts playback at the beginning of the currently playing entry.
    public func restartCurrentEntry()

    /// Starts playback of the previous entry in the playback queue.
    /// 
    /// If the music player isn’t playing, this method designates
    /// the previous entry as the next to play.
    ///
    /// When you call this method, playback ends if the music player is
    /// already at the first entry in the playback queue.
    public func skipToPreviousEntry() async throws

    @objc deinit
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer {

    /// A representation of the playback queue for a music player.
    public class Queue : ObservableObject, ExpressibleByArrayLiteral {

        /// Creates a playback queue with playable music items.
        required public init<S, PlayableMusicItemType>(for playableItems: S, startingAt startPlayableItem: S.Element? = nil) where S : Sequence, PlayableMusicItemType : PlayableMusicItem, PlayableMusicItemType == S.Element

        /// Creates a playback queue with playback queue entries.
        required public init<S>(_ entries: S, startingAt startEntry: S.Element? = nil) where S : Sequence, S.Element == MusicPlayer.Queue.Entry

        /// Creates a playback queue with an album and a specific track for the player to start playback.
        @available(iOS 16.4, tvOS 16.4, visionOS 1.0, macOS 14.0, *)
        required public init(album: Album, startingAt startTrack: Track)

        /// Creates a playback queue with a playlist and a specific playlist entry for the player to start playback.
        @available(iOS 16.4, tvOS 16.4, visionOS 1.0, macOS 14.0, *)
        required public init(playlist: Playlist, startingAt startPlaylistEntry: Playlist.Entry)

        /// The currently active entry in the playback queue.
        public var currentEntry: MusicPlayer.Queue.Entry?

        /// Inserts playable music items into the playback queue.
        public func insert<S, PlayableMusicItemType>(_ playableItems: S, position: MusicPlayer.Queue.EntryInsertionPosition) async throws where S : Sequence, PlayableMusicItemType : PlayableMusicItem, PlayableMusicItemType == S.Element

        /// Inserts entries into the playback queue.
        public func insert<S>(_ entries: S, position: MusicPlayer.Queue.EntryInsertionPosition) async throws where S : Sequence, S.Element == MusicPlayer.Queue.Entry

        /// Inserts a playable music item into the playback queue.
        public func insert<PlayableMusicItemType>(_ playableItem: PlayableMusicItemType, position: MusicPlayer.Queue.EntryInsertionPosition) async throws where PlayableMusicItemType : PlayableMusicItem

        /// Inserts an entry into the playback queue.
        public func insert(_ entry: MusicPlayer.Queue.Entry, position: MusicPlayer.Queue.EntryInsertionPosition) async throws

        /// A publisher that emits before the object has changed.
        public var objectWillChange: AnyPublisher<Void, Never> { get }

        /// Creates an instance initialized with the given elements.
        required public convenience init(arrayLiteral elements: any PlayableMusicItem...)

        /// The type of the elements of an array literal.
        @available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
        @available(watchOS, unavailable)
        public typealias ArrayLiteralElement = any PlayableMusicItem

        /// The type of publisher that emits before the object has changed.
        @available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
        @available(watchOS, unavailable)
        public typealias ObjectWillChangePublisher = AnyPublisher<Void, Never>

        @objc deinit
    }
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer {

    /// The music player playback status modes.
    ///
    /// You determine a music player’s state by checking the
    /// ``MusicKit/MusicPlayer/State-swift.class/playbackStatus`` property.
    /// Depending on the property’s value, you can update your
    /// app’s user interface or take other appropriate action.
    public enum PlaybackStatus : Equatable, Hashable, Sendable {

        /// The music player is in a stopped state.
        case stopped

        /// The music player is playing.
        case playing

        /// The music player is in a paused state.
        case paused

        /// The music player is in an interrupted state,
        /// such as from an incoming phone call.
        ///
        /// When an incoming phone call interrupts the music player,
        /// it may resume playing automatically upon ending the call.
        case interrupted

        /// The music player is seeking forward.
        case seekingForward

        /// The music player is seeking backward.
        case seekingBackward

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: MusicPlayer.PlaybackStatus, b: MusicPlayer.PlaybackStatus) -> Bool

        /// Hashes the essential components of this value by feeding them into the
        /// given hasher.
        ///
        /// Implement this method to conform to the `Hashable` protocol. The
        /// components used for hashing must be the same as the components compared
        /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
        /// with each of these components.
        ///
        /// - Important: In your implementation of `hash(into:)`,
        ///   don't call `finalize()` on the `hasher` instance provided,
        ///   or replace it with a different instance.
        ///   Doing so may become a compile-time error in the future.
        ///
        /// - Parameter hasher: The hasher to use when combining the components
        ///   of this instance.
        public func hash(into hasher: inout Hasher)

        /// The hash value.
        ///
        /// Hash values are not guaranteed to be equal across different executions of
        /// your program. Do not save hash values to use during a future execution.
        ///
        /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
        ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
        ///   The compiler provides an implementation for `hashValue` for you.
        public var hashValue: Int { get }
    }
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer {

    /// The repeat modes for the music player.
    public enum RepeatMode : Sendable {

        /// The repeat mode is in a disabled state.
        case none

        /// The music player is repeating the currently playing entry.
        case one

        /// The music player is repeating the currently playing collection,
        /// such as an album or a playlist.
        case all

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: MusicPlayer.RepeatMode, b: MusicPlayer.RepeatMode) -> Bool

        /// Hashes the essential components of this value by feeding them into the
        /// given hasher.
        ///
        /// Implement this method to conform to the `Hashable` protocol. The
        /// components used for hashing must be the same as the components compared
        /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
        /// with each of these components.
        ///
        /// - Important: In your implementation of `hash(into:)`,
        ///   don't call `finalize()` on the `hasher` instance provided,
        ///   or replace it with a different instance.
        ///   Doing so may become a compile-time error in the future.
        ///
        /// - Parameter hasher: The hasher to use when combining the components
        ///   of this instance.
        public func hash(into hasher: inout Hasher)

        /// The hash value.
        ///
        /// Hash values are not guaranteed to be equal across different executions of
        /// your program. Do not save hash values to use during a future execution.
        ///
        /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
        ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
        ///   The compiler provides an implementation for `hashValue` for you.
        public var hashValue: Int { get }
    }
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer {

    /// The shuffle modes for the music player.
    public enum ShuffleMode : Sendable {

        /// The shuffle mode is in a disabled state.
        case off

        /// The music player’s shuffle songs mode.
        case songs

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: MusicPlayer.ShuffleMode, b: MusicPlayer.ShuffleMode) -> Bool

        /// Hashes the essential components of this value by feeding them into the
        /// given hasher.
        ///
        /// Implement this method to conform to the `Hashable` protocol. The
        /// components used for hashing must be the same as the components compared
        /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
        /// with each of these components.
        ///
        /// - Important: In your implementation of `hash(into:)`,
        ///   don't call `finalize()` on the `hasher` instance provided,
        ///   or replace it with a different instance.
        ///   Doing so may become a compile-time error in the future.
        ///
        /// - Parameter hasher: The hasher to use when combining the components
        ///   of this instance.
        public func hash(into hasher: inout Hasher)

        /// The hash value.
        ///
        /// Hash values are not guaranteed to be equal across different executions of
        /// your program. Do not save hash values to use during a future execution.
        ///
        /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
        ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
        ///   The compiler provides an implementation for `hashValue` for you.
        public var hashValue: Int { get }
    }
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer {

    /// An object that exposes the observable properties of a music player.
    public class State : ObservableObject {

        /// The current playback status of the music player.
        public var playbackStatus: MusicPlayer.PlaybackStatus { get }

        /// The current playback rate for the player.
        ///
        /// This value represents a multiplier for the default playback rate of
        /// the current entry.
        /// A value of `0.0` indicates that the entry isn’t playing, and a value
        /// of `1.0` indicates that it’s playing at normal speed.
        /// Positive values indicate forward playback, and negative values
        /// indicate reverse playback.
        ///
        /// Setting the value of this property changes the playback rate
        /// accordingly.
        public var playbackRate: Float

        /// The current repeat mode of the music player.
        ///
        /// Defaults to `nil`.
        public var repeatMode: MusicPlayer.RepeatMode?

        /// The current shuffle mode of the music player.
        ///
        /// Defaults to `nil`.
        public var shuffleMode: MusicPlayer.ShuffleMode?

        /// The active variant that indicates the quality of audio
        /// for the current entry.
        @available(iOS 16.0, tvOS 16.0, visionOS 1.0, *)
        public var audioVariant: AudioVariant? { get }

        /// A publisher that emits before the object has changed.
        public var objectWillChange: AnyPublisher<Void, Never> { get }

        /// The type of publisher that emits before the object has changed.
        @available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
        @available(watchOS, unavailable)
        public typealias ObjectWillChangePublisher = AnyPublisher<Void, Never>

        @objc deinit
    }
}

@available(iOS 18.0, *)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension MusicPlayer {

    /// The transition applied between playing items.
    public enum Transition : Equatable, Hashable, Sendable {

        /// No transition.
        case none

        /// A smooth overlap between the currently playing item and the next item.
        case crossfade(options: MusicPlayer.Transition.CrossfadeOptions)

        /// A smooth overlap between the currently playing item and the next item with default options.
        public static let crossfade: MusicPlayer.Transition

        /// A smooth overlap between the currently playing item and the next item with a specified duration.
        public static func crossfade(duration: TimeInterval?) -> MusicPlayer.Transition

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: MusicPlayer.Transition, b: MusicPlayer.Transition) -> Bool

        /// Hashes the essential components of this value by feeding them into the
        /// given hasher.
        ///
        /// Implement this method to conform to the `Hashable` protocol. The
        /// components used for hashing must be the same as the components compared
        /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
        /// with each of these components.
        ///
        /// - Important: In your implementation of `hash(into:)`,
        ///   don't call `finalize()` on the `hasher` instance provided,
        ///   or replace it with a different instance.
        ///   Doing so may become a compile-time error in the future.
        ///
        /// - Parameter hasher: The hasher to use when combining the components
        ///   of this instance.
        public func hash(into hasher: inout Hasher)

        /// The hash value.
        ///
        /// Hash values are not guaranteed to be equal across different executions of
        /// your program. Do not save hash values to use during a future execution.
        ///
        /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
        ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
        ///   The compiler provides an implementation for `hashValue` for you.
        public var hashValue: Int { get }
    }
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer.Queue : Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (left: MusicPlayer.Queue, right: MusicPlayer.Queue) -> Bool
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer.Queue : Hashable {

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer.Queue {

    /// An enumeration for the various supported positions for inserting
    /// playable music items or entries in the playback queue.
    public enum EntryInsertionPosition : Sendable {

        /// A position that allows prepending entries in the playback queue,
        /// similar to the Play Next feature in the Music app.
        ///
        /// Inserting entries after the current one merely enqueues 
        /// them to play next, and lets the current entry finish
        /// playing to the end.
        ///
        /// Alternatively, you may change the current entry programmatically
        /// by setting the `currentEntry` property of the 
        /// ``ApplicationMusicPlayer/queue-swift.property`` or 
        /// ``SystemMusicPlayer/queue``.
        case afterCurrentEntry

        /// A position that allows appending entries in the playback queue,
        /// similar to the Play Later feature in the Music app.
        case tail

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: MusicPlayer.Queue.EntryInsertionPosition, b: MusicPlayer.Queue.EntryInsertionPosition) -> Bool

        /// Hashes the essential components of this value by feeding them into the
        /// given hasher.
        ///
        /// Implement this method to conform to the `Hashable` protocol. The
        /// components used for hashing must be the same as the components compared
        /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
        /// with each of these components.
        ///
        /// - Important: In your implementation of `hash(into:)`,
        ///   don't call `finalize()` on the `hasher` instance provided,
        ///   or replace it with a different instance.
        ///   Doing so may become a compile-time error in the future.
        ///
        /// - Parameter hasher: The hasher to use when combining the components
        ///   of this instance.
        public func hash(into hasher: inout Hasher)

        /// The hash value.
        ///
        /// Hash values are not guaranteed to be equal across different executions of
        /// your program. Do not save hash values to use during a future execution.
        ///
        /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
        ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
        ///   The compiler provides an implementation for `hashValue` for you.
        public var hashValue: Int { get }
    }
}

/// A set of properties for a playback queue entry.
@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer.Queue {

    /// An entry for the playback queue of the music player.
    public struct Entry : Equatable, Hashable, Identifiable, CustomStringConvertible {

        /// Creates an entry of the playback queue with
        /// a playable music item, and optional start and end times.
        public init(_ playableMusicItem: any PlayableMusicItem, startTime: TimeInterval? = nil, endTime: TimeInterval? = nil)

        /// The unique identifier of this entry of the playback queue.
        public let id: String

        /// The title of this entry of the playback queue.
        public var title: String { get }

        /// The subtitle of this entry of the playback queue.
        public var subtitle: String? { get }

        /// The artwork of this entry of the playback queue.
        public var artwork: Artwork? { get }

        /// A music item that corresponds to this entry of the playback queue,
        /// such as a song or a music video.
        public var item: MusicPlayer.Queue.Entry.Item? { get }

        /// A music item that corresponds to a recently inserted entry
        /// in the playback queue that has underlying items the music player
        /// still needs to resolve.
        public var transientItem: (any PlayableMusicItem)? { get }

        /// A Boolean value that indicates whether this entry of the playback
        /// queue has a transient music item.
        public var isTransient: Bool { get }

        /// An optional start time for this entry of the playback queue.
        public var startTime: TimeInterval? { get }

        /// An optional end time for this entry of the playback queue.
        public var endTime: TimeInterval? { get }

        /// A textual representation of this instance.
        ///
        /// Calling this property directly is discouraged. Instead, convert an
        /// instance of any type to a string by using the `String(describing:)`
        /// initializer. This initializer works with any type, and uses the custom
        /// `description` property for types that conform to
        /// `CustomStringConvertible`:
        ///
        ///     struct Point: CustomStringConvertible {
        ///         let x: Int, y: Int
        ///
        ///         var description: String {
        ///             return "(\(x), \(y))"
        ///         }
        ///     }
        ///
        ///     let p = Point(x: 21, y: 30)
        ///     let s = String(describing: p)
        ///     print(s)
        ///     // Prints "(21, 30)"
        ///
        /// The conversion of `p` to a string in the assignment to `s` uses the
        /// `Point` type's `description` property.
        public var description: String { get }

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: MusicPlayer.Queue.Entry, b: MusicPlayer.Queue.Entry) -> Bool

        /// A type representing the stable identity of the entity associated with
        /// an instance.
        @available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
        @available(watchOS, unavailable)
        public typealias ID = String

        /// Hashes the essential components of this value by feeding them into the
        /// given hasher.
        ///
        /// Implement this method to conform to the `Hashable` protocol. The
        /// components used for hashing must be the same as the components compared
        /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
        /// with each of these components.
        ///
        /// - Important: In your implementation of `hash(into:)`,
        ///   don't call `finalize()` on the `hasher` instance provided,
        ///   or replace it with a different instance.
        ///   Doing so may become a compile-time error in the future.
        ///
        /// - Parameter hasher: The hasher to use when combining the components
        ///   of this instance.
        public func hash(into hasher: inout Hasher)

        /// The hash value.
        ///
        /// Hash values are not guaranteed to be equal across different executions of
        /// your program. Do not save hash values to use during a future execution.
        ///
        /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
        ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
        ///   The compiler provides an implementation for `hashValue` for you.
        public var hashValue: Int { get }
    }
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer.RepeatMode : Equatable {
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer.RepeatMode : Hashable {
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer.ShuffleMode : Equatable {
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer.ShuffleMode : Hashable {
}

@available(iOS 18.0, *)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension MusicPlayer.Transition {

    /// The options for the crossfade transition.
    public struct CrossfadeOptions : Equatable, Hashable, Sendable {

        /// Creates options for a crossfade transition.
        public init(duration: TimeInterval? = nil)

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: MusicPlayer.Transition.CrossfadeOptions, b: MusicPlayer.Transition.CrossfadeOptions) -> Bool

        /// Hashes the essential components of this value by feeding them into the
        /// given hasher.
        ///
        /// Implement this method to conform to the `Hashable` protocol. The
        /// components used for hashing must be the same as the components compared
        /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
        /// with each of these components.
        ///
        /// - Important: In your implementation of `hash(into:)`,
        ///   don't call `finalize()` on the `hasher` instance provided,
        ///   or replace it with a different instance.
        ///   Doing so may become a compile-time error in the future.
        ///
        /// - Parameter hasher: The hasher to use when combining the components
        ///   of this instance.
        public func hash(into hasher: inout Hasher)

        /// The hash value.
        ///
        /// Hash values are not guaranteed to be equal across different executions of
        /// your program. Do not save hash values to use during a future execution.
        ///
        /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
        ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
        ///   The compiler provides an implementation for `hashValue` for you.
        public var hashValue: Int { get }
    }
}

@available(iOS 18.0, *)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension MusicPlayer.Transition : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer.Queue.EntryInsertionPosition : Equatable {
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer.Queue.EntryInsertionPosition : Hashable {
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer.Queue.Entry {

    /// An item that corresponds to an entry in the playback queue.
    public enum Item : MusicItem, Equatable, Hashable, Identifiable, Sendable {

        /// An item that corresponds to a song.
        case song(Song)

        /// An item that corresponds to a music video.
        case musicVideo(MusicVideo)

        /// The unique identifier for the music player item.
        public var id: MusicItemID { get }

        /// The parameters to use to play the item.
        public var playParameters: PlayParameters? { get }

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: MusicPlayer.Queue.Entry.Item, b: MusicPlayer.Queue.Entry.Item) -> Bool

        /// A type representing the stable identity of the entity associated with
        /// an instance.
        @available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
        @available(watchOS, unavailable)
        public typealias ID = MusicItemID

        /// Hashes the essential components of this value by feeding them into the
        /// given hasher.
        ///
        /// Implement this method to conform to the `Hashable` protocol. The
        /// components used for hashing must be the same as the components compared
        /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
        /// with each of these components.
        ///
        /// - Important: In your implementation of `hash(into:)`,
        ///   don't call `finalize()` on the `hasher` instance provided,
        ///   or replace it with a different instance.
        ///   Doing so may become a compile-time error in the future.
        ///
        /// - Parameter hasher: The hasher to use when combining the components
        ///   of this instance.
        public func hash(into hasher: inout Hasher)

        /// The hash value.
        ///
        /// Hash values are not guaranteed to be equal across different executions of
        /// your program. Do not save hash values to use during a future execution.
        ///
        /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
        ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
        ///   The compiler provides an implementation for `hashValue` for you.
        public var hashValue: Int { get }
    }
}

@available(iOS 18.0, *)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension MusicPlayer.Transition.CrossfadeOptions : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer.Queue.Entry.Item : MusicPropertyContainer {
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer.Queue.Entry.Item : PlayableMusicItem {
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer.Queue.Entry.Item : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension MusicPlayer.Queue.Entry.Item : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// A protocol for music items that your app can add to a playlist.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
public protocol MusicPlaylistAddable : MusicItem {
}

/// A protocol for music items that allow loading additional
/// properties that you can fetch asynchronously.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public protocol MusicPropertyContainer {

    /// Loads a new instance of the music item that includes
    /// the specified properties.
    ///
    /// This asynchronous method fetches a more complete representation
    /// of the receiver from Apple Music API over the network.
    func with(_ properties: [PartialMusicAsyncProperty<Self>]) async throws -> Self

    /// Loads a new instance of the music item that includes
    /// the specified properties.
    ///
    /// This asynchronous method fetches a more complete representation
    /// of the receiver, loading the contents for each property you request 
    /// from either the Apple Music catalog or the user’s library, depending 
    /// on the preferred source as well the availability of the content in those 
    /// respective data sources.
    ///
    /// For example, if you want to load the
    /// ``PartialMusicProperty/tracks-9mk2l`` relationship for
    /// an ``Album``, as found in the user’s library, as well as other
    /// associations of content that only live in the Apple Music catalog,
    /// like the ``PartialMusicProperty/recordLabels`` and
    /// ``PartialMusicProperty/relatedAlbums`` associations,
    /// you can use this code:
    /// 
    ///     let album: Album = …
    ///     let detailedAlbum = try await album.with(
    ///         [
    ///             .tracks,
    ///             .recordLabels,
    ///             .relatedAlbums
    ///         ],
    ///         preferredSource: .library
    ///     )
    /// 
    /// Here, because the ``PartialMusicProperty/tracks-9mk2l`` relationship
    /// for an ``Album`` is supported in both the library and the catalog,
    /// and because the this code specifically requests
    /// ``MusicPropertySource/library`` as the preferred source,
    /// the framework will load the tracks from the user’s library.
    /// However, because the ``PartialMusicProperty/recordLabels``
    /// and ``PartialMusicProperty/relatedAlbums`` associations are only
    /// available in the Apple Music catalog, the framework will also issue
    /// a network request to Apple Music API to fetch those associations
    /// of content from the catalog.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
    func with(_ properties: [PartialMusicAsyncProperty<Self>], preferredSource: MusicPropertySource) async throws -> Self

    /// Loads a new instance of the music item that includes
    /// the specified properties.
    ///
    /// This asynchronous method fetches a more complete representation
    /// of the receiver, loading the contents for each property you request 
    /// from either the Apple Music catalog or the user’s library, depending 
    /// on the preferred source as well the availability of the content in those 
    /// respective data sources.
    ///
    /// For example, if you want to load the
    /// ``PartialMusicProperty/tracks-9mk2l`` relationship for
    /// an ``Album``, as found in the user’s library, as well as other
    /// associations of content that only live in the Apple Music catalog,
    /// like the ``PartialMusicProperty/recordLabels`` and
    /// ``PartialMusicProperty/relatedAlbums`` associations,
    /// you can use this code:
    /// 
    ///     let album: Album = …
    ///     let detailedAlbum = try await album.with(
    ///         .tracks,
    ///         .recordLabels,
    ///         .relatedAlbums, 
    ///         preferredSource: .library
    ///     )
    /// 
    /// Here, because the ``PartialMusicProperty/tracks-9mk2l`` relationship
    /// for an ``Album`` is supported in both the library and the catalog,
    /// and because the this code specifically requests
    /// ``MusicPropertySource/library`` as the preferred source,
    /// the framework will load the tracks from the user’s library.
    /// However, because the ``PartialMusicProperty/recordLabels``
    /// and ``PartialMusicProperty/relatedAlbums`` associations are only
    /// available in the Apple Music catalog, the framework will also issue
    /// a network request to Apple Music API to fetch those associations
    /// of content from the catalog.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
    func with(_ properties: PartialMusicAsyncProperty<Self>..., preferredSource: MusicPropertySource) async throws -> Self
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicPropertyContainer {

    /// Loads a new instance of the music item that includes
    /// the specified properties.
    ///
    /// This asynchronous method fetches a more complete representation
    /// of the receiver from Apple Music API over the network.
    public func with(_ properties: PartialMusicAsyncProperty<Self>...) async throws -> Self
}

/// An enumeration that specifies which source to use when requesting properties and relationships.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public enum MusicPropertySource : CaseIterable, Codable, Equatable, Hashable, Sendable {

    /// The source representing the Apple Music catalog.
    case catalog

    /// The source representing the user’s music library.
    @available(macOS 14.0, macCatalyst 17.0, *)
    case library

    /// A collection of all values of this type.
    public static var allCases: [MusicPropertySource] { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicPropertySource, b: MusicPropertySource) -> Bool

    /// A type that can represent a collection of all values of this type.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 13.0, *)
    public typealias AllCases = [MusicPropertySource]

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws
}

/// A request that your app uses to fetch albums, playlists or stations
/// that the user has recently played.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public typealias MusicRecentlyPlayedContainerRequest = MusicRecentlyPlayedRequest<RecentlyPlayedMusicItem>

/// An object that contains albums, playlists or stations
/// that the user has recently played.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public typealias MusicRecentlyPlayedContainerResponse = MusicRecentlyPlayedResponse<RecentlyPlayedMusicItem>

/// A request that your app uses to fetch items the user has recently played.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public struct MusicRecentlyPlayedRequest<MusicItemType> where MusicItemType : MusicRecentlyPlayedRequestable, MusicItemType : Decodable {

    /// Creates a request for items the user has recently played.
    public init()

    /// A limit for the number of items to return
    /// in the response that contains items the user has recently played.
    public var limit: Int?

    /// An offet for the request.
    public var offset: Int?

    /// Fetches items the user has recently played.
    public func response() async throws -> MusicRecentlyPlayedResponse<MusicItemType>
}

/// A protocol for music items that your app can fetch by
/// using a recently played request.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public protocol MusicRecentlyPlayedRequestable : MusicItem {
}

/// An object that contains items the user has recently played.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public struct MusicRecentlyPlayedResponse<MusicItemType> where MusicItemType : MusicRecentlyPlayedRequestable {

    /// A collection of items the user has recently played.
    public let items: MusicItemCollection<MusicItemType>
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicRecentlyPlayedResponse : Equatable where MusicItemType : Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicRecentlyPlayedResponse<MusicItemType>, b: MusicRecentlyPlayedResponse<MusicItemType>) -> Bool
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicRecentlyPlayedResponse : Hashable where MusicItemType : Hashable {

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicRecentlyPlayedResponse : Sendable {
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicRecentlyPlayedResponse : Decodable where MusicItemType : Decodable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicRecentlyPlayedResponse : Encodable where MusicItemType : Encodable {

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicRecentlyPlayedResponse : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// An identifier for a music item relationship property
/// from a specific root type to a specific value type
/// for the element of the resulting collection.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public class MusicRelationshipProperty<Root, RelatedMusicItemType> : PartialMusicAsyncProperty<Root>, CustomStringConvertible, @unchecked Sendable where RelatedMusicItemType : MusicItem, RelatedMusicItemType : Decodable {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    @objc deinit
}

/// A representation of the current state of the user’s subscription
/// to Apple Music.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct MusicSubscription : Equatable, Hashable, Sendable, CustomStringConvertible {

    /// A capability that allows your app to play subscription content
    /// using a music player.
    public let canPlayCatalogContent: Bool

    /// A capability that allows your app to present subscription offers
    /// for Apple Music.
    public let canBecomeSubscriber: Bool

    /// A capability that allows your app to perform modifications to the
    /// user’s iCloud Music Library.
    public let hasCloudLibraryEnabled: Bool

    /// The current state of the user’s subscription to Apple Music.
    public static var current: MusicSubscription { get async throws }

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicSubscription, b: MusicSubscription) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicSubscription {

    /// An asynchronous sequence to use for observing updates to
    /// the current state of the user’s subscription to Apple Music.
    public struct Updates : AsyncSequence {

        /// An iterator for the asynchronous sequence to use for observing
        /// updates to the current state of the user’s subscription
        /// to Apple Music.
        public struct Iterator : AsyncIteratorProtocol {

            /// Asynchronously advances to the next element and returns it, or ends the
            /// sequence if there is no next element.
            ///
            /// - Returns: The next element, if it exists, or `nil` to signal the end of
            ///   the sequence.
            public mutating func next() async -> MusicSubscription?

            @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
            public typealias Element = MusicSubscription
        }

        /// The type of element the asynchronous sequence produces.
        public typealias Element = MusicSubscription

        /// Creates the asynchronous iterator that produces elements of this
        /// asynchronous sequence.
        ///
        /// - Returns: An instance of the `AsyncIterator` type used to produce
        /// elements of the asynchronous sequence.
        public func makeAsyncIterator() -> MusicSubscription.Updates.Iterator

        /// The type of asynchronous iterator that produces elements of this
        /// asynchronous sequence.
        @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
        public typealias AsyncIterator = MusicSubscription.Updates.Iterator
    }

    /// An asynchronous sequence to use for observing updates to
    /// the current state of the user’s subscription to Apple Music.
    public static var subscriptionUpdates: MusicSubscription.Updates { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicSubscription {

    /// An error that MusicKit can throw upon requesting the
    /// current music subscription of the user.
    public enum Error : String, LocalizedError, Sendable {

        /// An error indicating the ocurrence of an unknown or unexpected error.
        case unknown

        /// An error indicating that the user doesn’t consent
        /// for your app to access their Apple Music data.
        case permissionDenied

        /// An error indicating that the user needs to acknowledge
        /// the most-recent privacy policy for Apple Music.
        case privacyAcknowledgementRequired

        /// A localized message describing what error occurred.
        public var errorDescription: String? { get }

        /// A localized message describing the reason for the failure.
        public var failureReason: String? { get }

        /// A localized message describing how one might recover from the failure.
        public var recoverySuggestion: String? { get }

        /// A localized message providing "help" text if the user requests help.
        public var helpAnchor: String? { get }

        /// Creates a new instance with the specified raw value.
        ///
        /// If there is no value of the type that corresponds with the specified raw
        /// value, this initializer returns `nil`. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     print(PaperSize(rawValue: "Legal"))
        ///     // Prints "Optional(PaperSize.Legal)"
        ///
        ///     print(PaperSize(rawValue: "Tabloid"))
        ///     // Prints "nil"
        ///
        /// - Parameter rawValue: The raw value to use for the new instance.
        public init?(rawValue: String)

        /// The raw type that can be used to represent all values of the conforming
        /// type.
        ///
        /// Every distinct value of the conforming type has a corresponding unique
        /// value of the `RawValue` type, but there may be values of the `RawValue`
        /// type that don't have a corresponding value of the conforming type.
        @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
        public typealias RawValue = String

        /// The corresponding value of the raw type.
        ///
        /// A new instance initialized with `rawValue` will be equivalent to this
        /// instance. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     let selectedSize = PaperSize.Letter
        ///     print(selectedSize.rawValue)
        ///     // Prints "Letter"
        ///
        ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
        ///     // Prints "true"
        public var rawValue: String { get }
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicSubscription.Error : CustomStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicSubscription.Error : Equatable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicSubscription.Error : Hashable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicSubscription.Error : RawRepresentable {
}

/// An object that music requests use to access Apple Music API.
///
/// A token provider for MusicKit needs to be a subclass of 
/// ``MusicUserTokenProvider`` which conforms to the
/// ``MusicDeveloperTokenProvider`` protocol.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public typealias MusicTokenProvider = MusicUserTokenProvider & MusicDeveloperTokenProvider

/// An error that the token provider or music requests can throw
/// upon requesting any token necessary for accessing Apple Music API.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public enum MusicTokenRequestError : String, LocalizedError, Sendable, CustomStringConvertible {

    /// An error indicating the ocurrence of an unknown or unexpected error.
    case unknown

    /// An error that occurs when the user doesn’t consent for the
    /// current app to access their Apple Music data.
    ///
    /// Apps using MusicKit need to request prior informed consent
    /// from the user to access their Apple Music data by calling
    /// ``MusicAuthorization/request()`` at the appropriate point in the
    /// app flow, right before needing to use other APIs from MusicKit.
    case permissionDenied

    /// An error that occurs when the user revokes permission for the
    /// current app to access their Apple Music data.
    ///
    /// In iOS, apps may attempt to recover from this error condition
    /// by suggesting to their users that they can grant access to their
    /// Apple Music data again by linking to
    /// <doc://com.apple.documentation/documentation/UIKit/UIApplication/1623042-openSettingsURLString>.
    case userTokenRevoked

    /// An error that occurs when the user isn’t signed in with an
    /// Apple Music account.
    case userNotSignedIn

    /// An error that occurs when the user needs to acknowledge the most recent
    /// privacy policy.
    case privacyAcknowledgementRequired

    /// An error that indicates a failure in the process of fetching
    /// a developer token for the current app.
    case developerTokenRequestFailed

    /// An error that indicates a failure in the process of fetching
    /// a user token.
    case userTokenRequestFailed

    /// A localized message describing what error occurred.
    public var errorDescription: String? { get }

    /// A localized message describing the reason for the failure.
    public var failureReason: String? { get }

    /// A localized message describing how one might recover from the failure.
    public var recoverySuggestion: String? { get }

    /// A localized message providing "help" text if the user requests help.
    public var helpAnchor: String? { get }

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// Creates a new instance with the specified raw value.
    ///
    /// If there is no value of the type that corresponds with the specified raw
    /// value, this initializer returns `nil`. For example:
    ///
    ///     enum PaperSize: String {
    ///         case A4, A5, Letter, Legal
    ///     }
    ///
    ///     print(PaperSize(rawValue: "Legal"))
    ///     // Prints "Optional(PaperSize.Legal)"
    ///
    ///     print(PaperSize(rawValue: "Tabloid"))
    ///     // Prints "nil"
    ///
    /// - Parameter rawValue: The raw value to use for the new instance.
    public init?(rawValue: String)

    /// The raw type that can be used to represent all values of the conforming
    /// type.
    ///
    /// Every distinct value of the conforming type has a corresponding unique
    /// value of the `RawValue` type, but there may be values of the `RawValue`
    /// type that don't have a corresponding value of the conforming type.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias RawValue = String

    /// The corresponding value of the raw type.
    ///
    /// A new instance initialized with `rawValue` will be equivalent to this
    /// instance. For example:
    ///
    ///     enum PaperSize: String {
    ///         case A4, A5, Letter, Legal
    ///     }
    ///
    ///     let selectedSize = PaperSize.Letter
    ///     print(selectedSize.rawValue)
    ///     // Prints "Letter"
    ///
    ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
    ///     // Prints "true"
    public var rawValue: String { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicTokenRequestError : Equatable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicTokenRequestError : Hashable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicTokenRequestError : RawRepresentable {
}

/// Options that music requests pass into token provider methods to fetch
/// a required token for accessing Apple Music API.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct MusicTokenRequestOptions : OptionSet, Sendable {

    /// Creates a new option set from the given raw value.
    ///
    /// This initializer always succeeds, even if the value passed as `rawValue`
    /// exceeds the static properties declared as part of the option set. This
    /// example creates an instance of `ShippingOptions` with a raw value beyond
    /// the highest element, with a bit mask that effectively contains all the
    /// declared static members.
    ///
    ///     let extraOptions = ShippingOptions(rawValue: 255)
    ///     print(extraOptions.isStrictSuperset(of: .all))
    ///     // Prints "true"
    ///
    /// - Parameter rawValue: The raw value of the option set to create. Each bit
    ///   of `rawValue` potentially represents an element of the option set,
    ///   though raw values may include bits that are not defined as distinct
    ///   values of the `OptionSet` type.
    public init(rawValue: Int)

    /// The corresponding value of the raw type.
    ///
    /// A new instance initialized with `rawValue` will be equivalent to this
    /// instance. For example:
    ///
    ///     enum PaperSize: String {
    ///         case A4, A5, Letter, Legal
    ///     }
    ///
    ///     let selectedSize = PaperSize.Letter
    ///     print(selectedSize.rawValue)
    ///     // Prints "Letter"
    ///
    ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
    ///     // Prints "true"
    public let rawValue: Int

    /// An option that indicates the token provider needs to discard
    /// any cached token and generate a new token.
    ///
    /// You can add the newly generated token to an in-memory or persistent
    /// cache for faster access upon subsequent requests for this token.
    public static let ignoreCache: MusicTokenRequestOptions

    /// The type of the elements of an array literal.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias ArrayLiteralElement = MusicTokenRequestOptions

    /// The element type of the option set.
    ///
    /// To inherit all the default implementations from the `OptionSet` protocol,
    /// the `Element` type must be `Self`, the default.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias Element = MusicTokenRequestOptions

    /// The raw type that can be used to represent all values of the conforming
    /// type.
    ///
    /// Every distinct value of the conforming type has a corresponding unique
    /// value of the `RawValue` type, but there may be values of the `RawValue`
    /// type that don't have a corresponding value of the conforming type.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias RawValue = Int
}

/// A class that music requests use to fetch user tokens your app requires
/// to access Apple Music API.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
open class MusicUserTokenProvider {

    /// Creates a user token provider.
    public init()

    /// Fetches and returns a user token for Apple Music API.
    public func userToken(for developerToken: String, options: MusicTokenRequestOptions) async throws -> String

    @objc deinit
}

/// A music item that represents a music video.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct MusicVideo : MusicItem, Equatable, Hashable, Identifiable, Sendable {

    /// The unique identifier for the music video.
    public let id: MusicItemID

    /// The artwork for the music video.
    public var artwork: Artwork? { get }

    /// The title of the album the music video appears on.
    public var albumTitle: String? { get }

    /// The artist’s name.
    public var artistName: String { get }

    /// The artist’s URL.
    public var artistURL: URL? { get }

    /// The rating of the content.
    ///
    /// A nil value means no rating is available for this music video.
    public var contentRating: ContentRating? { get }

    /// The duration of the music video.
    public var duration: TimeInterval? { get }

    /// The editorial notes for the music video.
    public var editorialNotes: EditorialNotes? { get }

    /// The names of the music video’s associated genres.
    public var genreNames: [String] { get }

    /// A Boolean value that indicates whether the music video has 4K content.
    public var has4K: Bool? { get }

    /// A Boolean value that indicates whether the music video
    /// has HDR10-encoded content.
    public var hasHDR: Bool? { get }

    /// A Boolean value that indicates whether this content corresponds to a subscription video preview.
    public var isPreview: Bool { get }

    /// The International Standard Recording Code (ISRC) for the music video.
    public var isrc: String? { get }

    /// The date when the user last played the music video on this device.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
    public var lastPlayedDate: Date? { get }

    /// The date when the user added the music video to the library.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
    public var libraryAddedDate: Date? { get }

    /// The number of times the user played the music video.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
    public var playCount: Int? { get }

    /// The parameters to use to play the music video.
    public var playParameters: PlayParameters? { get }

    /// The preview assets for the music video.
    public var previewAssets: [PreviewAsset]? { get }

    /// The release date (or expected prerelease date) for the music video.
    public var releaseDate: Date? { get }

    /// The title of the music video.
    public var title: String { get }

    /// The music video’s number in the album’s track list.
    public var trackNumber: Int? { get }

    /// The URL for the music video.
    public var url: URL? { get }

    /// For classical music only, the name of the associated work.
    public var workName: String? { get }

    /// The music video’s associated albums.
    public var albums: MusicItemCollection<Album>? { get }

    /// The music video’s associated artists.
    public var artists: MusicItemCollection<Artist>? { get }

    /// The music video’s associated genres.
    public var genres: MusicItemCollection<Genre>? { get }

    /// The music video’s associated songs.
    public var songs: MusicItemCollection<Song>? { get }

    /// A collection of additional music videos by the artist.
    public var moreByArtist: MusicItemCollection<MusicVideo>? { get }

    /// A collection of music videos in the same genre as this music video.
    public var moreInGenre: MusicItemCollection<MusicVideo>? { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicVideo, b: MusicVideo) -> Bool

    /// A type representing the stable identity of the entity associated with
    /// an instance.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias ID = MusicItemID

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicVideo : MusicPropertyContainer {
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicVideo : MusicCatalogChartRequestable {
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
extension MusicVideo : MusicCatalogSearchable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicVideo : FilterableMusicItem {

    /// The associated type that contains the set of music video properties
    /// your app uses as a filter for a catalog resource request.
    public typealias FilterType = MusicVideoFilter
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
extension MusicVideo : MusicLibraryAddable, MusicPlaylistAddable {
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicVideo : MusicLibraryRequestable {

    /// The associated type that contains the music video properties
    /// your app uses for a library request.
    public typealias LibraryFilter = LibraryMusicVideoFilter

    /// The associated type that contains the set of music video properties
    /// your app uses to sort results for a library request.
    public typealias LibrarySortProperties = LibraryMusicVideoSortProperties
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension MusicVideo : MusicLibrarySearchable {
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicVideo : MusicRecentlyPlayedRequestable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicVideo : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension MusicVideo : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// Music video properties your app uses as a filter
/// for a catalog resource request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public protocol MusicVideoFilter {

    /// The unique identifier for the music video.
    var id: MusicItemID { get }

    /// The International Standard Recording Code (ISRC) for the music video.
    var isrc: String? { get }
}

/// A partially type-erased identifier for a music item property
/// that you can fetch asynchronously from a concrete root type
/// to any resulting value type.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public class PartialMusicAsyncProperty<Root> : PartialMusicProperty<Root>, @unchecked Sendable {

    @objc deinit
}

/// A partially type-erased identifier for a music item property
/// from a concrete root type to any resulting value type.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public class PartialMusicProperty<Root> : AnyMusicProperty, @unchecked Sendable {

    @objc deinit
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
extension PartialMusicProperty where Root == Curator {

    /// An identifier for the relationship property that returns
    /// the associated playlists for the curator.
    public static let playlists: MusicRelationshipProperty<Curator, Playlist>
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension PartialMusicProperty where Root == RecordLabel {

    /// An identifier for the association property that returns
    /// a collection of the most recent releases for the record label.
    public static var latestReleases: MusicRelationshipProperty<RecordLabel, Album> { get }

    /// An identifier for the association property that returns
    /// a collection of top releases for the record label.
    public static var topReleases: MusicRelationshipProperty<RecordLabel, Album> { get }
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
extension PartialMusicProperty where Root == RadioShow {

    /// An identifier for the relationship property that returns
    /// the associated playlists for the radio show.
    public static let playlists: MusicRelationshipProperty<RadioShow, Playlist>
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension PartialMusicProperty where Root == MusicVideo {

    /// An identifier for the extended attribute property that returns
    /// the artist’s URL.
    public static var artistURL: MusicExtendedAttributeProperty<MusicVideo, URL> { get }

    /// An identifier of the relationship property that returns
    /// the associated albums for the music video.
    public static let albums: MusicRelationshipProperty<MusicVideo, Album>

    /// An identifier of the relationship property that returns
    /// the associated artists for the music video.
    public static let artists: MusicRelationshipProperty<MusicVideo, Artist>

    /// An identifier of the relationship property that returns
    /// the associated genres for the music video.
    public static let genres: MusicRelationshipProperty<MusicVideo, Genre>

    /// An identifier of the relationship property that returns
    /// the associated songs for the music video.
    public static let songs: MusicRelationshipProperty<MusicVideo, Song>

    /// An identifier of the association property that returns
    /// a collection of additional music videos by the artist.
    public static let moreByArtist: MusicRelationshipProperty<MusicVideo, MusicVideo>

    /// A identifier of the association property that returns
    /// a collection of music videos in the same genre as this music video.
    public static let moreInGenre: MusicRelationshipProperty<MusicVideo, MusicVideo>
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension PartialMusicProperty where Root == Artist {

    /// An identifier for the relationship property that returns
    /// the associated albums for the artist.
    public static let albums: MusicRelationshipProperty<Artist, Album>

    /// An identifier for the relationship property that returns
    /// the associated genres for the artist.
    public static let genres: MusicRelationshipProperty<Artist, Genre>

    /// An identifier for the relationship property that returns
    /// the associated music videos for the artist.
    public static let musicVideos: MusicRelationshipProperty<Artist, MusicVideo>

    /// An identifier for the relationship property that returns
    /// the associated playlists for the artist.
    public static let playlists: MusicRelationshipProperty<Artist, Playlist>

    /// An identifier for the relationship property that returns
    /// the associated station for the artist.
    public static let station: MusicRelationshipProperty<Artist, Station>

    /// An identifier for the association property that returns
    /// a collection of albums from other artists that this artist appears on.
    public static let appearsOnAlbums: MusicRelationshipProperty<Artist, Album>

    /// An identifier for the association property that returns
    /// a collection of compilation albums that include tracks by the artist.
    public static let compilationAlbums: MusicRelationshipProperty<Artist, Album>

    /// An identifier for the association property that returns
    /// a collection of featured albums for the artist.
    public static let featuredAlbums: MusicRelationshipProperty<Artist, Album>

    /// An identifier for the association property that returns
    /// a collection of the artist’s playlists.
    public static let featuredPlaylists: MusicRelationshipProperty<Artist, Playlist>

    /// An identifier for the association property that returns
    /// a collection of the artist’s full-release albums.
    public static let fullAlbums: MusicRelationshipProperty<Artist, Album>

    /// An identifier for the association property that returns
    /// the artist’s most recent album.
    public static let latestRelease: MusicRelationshipProperty<Artist, Album>

    /// An identifier for the association property that returns
    /// a collection of the artist’s live albums.
    public static let liveAlbums: MusicRelationshipProperty<Artist, Album>

    /// An identifier for the association property that returns
    /// a collection of artists similar to this artist.
    public static let similarArtists: MusicRelationshipProperty<Artist, Artist>

    /// An identifier of the association property that returns
    /// a collection of the artist’s albums in the _singles_ category.
    public static let singles: MusicRelationshipProperty<Artist, Album>

    /// An identifier for the association property that returns
    /// a collection of the artist’s top music videos.
    public static let topMusicVideos: MusicRelationshipProperty<Artist, MusicVideo>

    /// An identifier for the association property that returns
    /// a collection of the artist’s top songs.
    public static let topSongs: MusicRelationshipProperty<Artist, Song>
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension PartialMusicProperty where Root == Playlist {

    /// An identifier for the relationship property that returns
    /// the tracks in the playlist.
    public static let tracks: MusicRelationshipProperty<Playlist, Track>

    /// An identifier for the association property that returns
    /// a collection of featured artists for this playlist.
    public static let featuredArtists: MusicRelationshipProperty<Playlist, Artist>

    /// An identifier for the association property that returns
    /// a collection of additional playlists by the same curator.
    public static let moreByCurator: MusicRelationshipProperty<Playlist, Playlist>
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension PartialMusicProperty where Root == Playlist {

    /// An identifier for the extended attribute property that returns
    /// the playlist’s associated curator.
    public static let curator: MusicRelationshipProperty<Playlist, Curator>

    /// An identifier for the relationship property that returns
    /// the entries in the playlist.
    public static let entries: MusicRelationshipProperty<Playlist, Playlist.Entry>

    /// An identifier for the extended attribute property that returns
    /// the playlist’s associated radio show.
    public static let radioShow: MusicRelationshipProperty<Playlist, RadioShow>
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension PartialMusicProperty where Root == Song {

    /// An identifier for the extended attribute property that returns
    /// the artist’s URL.
    public static var artistURL: MusicExtendedAttributeProperty<Song, URL> { get }

    /// An identifier for the relationship property that returns
    /// the associated albums for the song.
    public static let albums: MusicRelationshipProperty<Song, Album>

    /// An identifier for the relationship property that returns
    /// the associated artists for the song.
    public static let artists: MusicRelationshipProperty<Song, Artist>

    /// An identifier for the relationship property that returns
    /// the associated genres for the song.
    public static let genres: MusicRelationshipProperty<Song, Genre>

    /// An identifier for the relationship property that returns
    /// the associated station for the song.
    public static let station: MusicRelationshipProperty<Song, Station>

    /// An identifier for the relationship property that returns
    /// the song’s composers.
    public static let composers: MusicRelationshipProperty<Song, Artist>

    /// An identifier for the relationship property that returns
    /// the song’s associated music videos.
    public static let musicVideos: MusicRelationshipProperty<Song, MusicVideo>
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension PartialMusicProperty where Root == Song {

    /// An identifier for the extended attribute property that returns
    /// the audio variants for the song.
    public static let audioVariants: MusicExtendedAttributeProperty<Song, [AudioVariant]>
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension PartialMusicProperty where Root == Album {

    /// An identifier for the extended attribute property that returns
    /// the artist’s URL.
    public static var artistURL: MusicExtendedAttributeProperty<Album, URL> { get }

    /// An identifier for the relationship property that returns
    /// the associated artists for the album.
    public static let artists: MusicRelationshipProperty<Album, Artist>

    /// An identifier for the relationship property that returns
    /// the genres for the album.
    public static let genres: MusicRelationshipProperty<Album, Genre>

    /// An identifier for the relationship property that returns
    /// the tracks on the album.
    public static let tracks: MusicRelationshipProperty<Album, Track>

    /// An identifier for the relationship property that returns
    /// the record labels for the album.
    public static let recordLabels: MusicRelationshipProperty<Album, RecordLabel>

    /// An identifier for the association property that returns
    /// a collection of playlists that include tracks from the album.
    public static let appearsOn: MusicRelationshipProperty<Album, Playlist>

    /// An identifier for the association property that returns
    /// a collection of other versions of the album.
    public static let otherVersions: MusicRelationshipProperty<Album, Album>

    /// An identifier for the association property that returns
    /// a collection of related albums.
    public static let relatedAlbums: MusicRelationshipProperty<Album, Album>

    /// An identifier for the association property that returns
    /// a collection of related music videos for the album.
    public static let relatedVideos: MusicRelationshipProperty<Album, MusicVideo>
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension PartialMusicProperty where Root == Album {

    /// An identifier for the extended attribute property that returns
    /// the audio variants for the album.
    public static let audioVariants: MusicExtendedAttributeProperty<Album, [AudioVariant]>
}

/// An opaque object that represents parameters to initiate playback
/// of a playable music item using a music player.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct PlayParameters : Equatable, Hashable, Sendable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: PlayParameters, b: PlayParameters) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension PlayParameters : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

/// A set of properties that a music player uses to initiate playback
/// for a music item.
@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
public protocol PlayableMusicItem : MusicItem {

    /// The parameters to use to play the music item.
    var playParameters: PlayParameters? { get }
}

/// A music item that represents a playlist.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct Playlist : MusicItem, Equatable, Hashable, Identifiable, Sendable {

    /// The unique identifier for the playlist.
    public let id: MusicItemID

    /// The artwork for the playlist.
    public var artwork: Artwork? { get }

    /// The display name for the playlist’s curator.
    public var curatorName: String? { get }

    /// A Boolean value that indicates whether the playlist represents a popularity chart.
    public var isChart: Bool? { get }

    /// The kind of playlist.
    public var kind: Playlist.Kind? { get }

    /// The playlist’s most recent modification date.
    public var lastModifiedDate: Date? { get }

    /// The date when the user last played the playlist on this device.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
    public var lastPlayedDate: Date? { get }

    /// The date when the user added the playlist to the library.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
    public var libraryAddedDate: Date? { get }

    /// The name of the playlist.
    public var name: String { get }

    /// The parameters to use to play the tracks in the playlist.
    public var playParameters: PlayParameters? { get }

    /// An abbreviated description to show inline or when the playlist
    /// appears alongside other content.
    public var shortDescription: String? { get }

    /// A description to show when the playlist is prominently displayed.
    public var standardDescription: String? { get }

    /// The URL for the playlist.
    public var url: URL? { get }

    /// The playlist’s associated curator.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
    public var curator: Curator? { get }

    /// The entries in the playlist
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
    public var entries: MusicItemCollection<Playlist.Entry>? { get }

    /// The playlist’s associated radio show.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
    public var radioShow: RadioShow? { get }

    /// The tracks in the playlist.
    public var tracks: MusicItemCollection<Track>? { get }

    /// A collection of featured artists for this playlist.
    public var featuredArtists: MusicItemCollection<Artist>? { get }

    /// A collection of additional playlists by the same curator.
    public var moreByCurator: MusicItemCollection<Playlist>? { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: Playlist, b: Playlist) -> Bool

    /// A type representing the stable identity of the entity associated with
    /// an instance.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias ID = MusicItemID

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Playlist {

    /// A music item that represents a playlist entry.
    public struct Entry : MusicItem, Equatable, Hashable, Identifiable, Sendable {

        /// The unique identifier for the playlist entry.
        public let id: MusicItemID

        /// The artwork of the playlist entry.
        public var artwork: Artwork? { get }

        /// The title of the album the playlist entry appears on.
        public var albumTitle: String? { get }

        /// The artist’s name.
        public var artistName: String { get }

        /// The artist’s URL.
        public var artistURL: URL? { get }

        /// The rating of the content.
        ///
        /// A nil value means no rating is available for this playlist entry.
        public var contentRating: ContentRating? { get }

        /// The duration of the playlist entry.
        public var duration: TimeInterval? { get }

        /// The editorial notes for the playlist entry.
        public var editorialNotes: EditorialNotes? { get }

        /// The names of the playlist entry’s associated genres.
        public var genreNames: [String] { get }

        /// The date when the user last played the playlist entry on this device.
        @available(macOS 14.0, macCatalyst 17.0, *)
        public var lastPlayedDate: Date? { get }

        /// The date when the user added the playlist entry to the library.
        @available(macOS 14.0, macCatalyst 17.0, *)
        public var libraryAddedDate: Date? { get }

        /// The number of times the user played the playlist entry.
        @available(macOS 14.0, macCatalyst 17.0, *)
        public var playCount: Int? { get }

        /// The International Standard Recording Code (ISRC) for the playlist entry.
        public var isrc: String? { get }

        /// The item of the playlist entry.
        public var item: Playlist.Entry.Item? { get }

        /// The parameters to use to play the playlist entry.
        public var playParameters: PlayParameters? { get }

        /// The position of the playlist entry.
        public var position: Int { get }

        /// The preview assets for the playlist entry.
        public var previewAssets: [PreviewAsset]? { get }

        /// The release date (or expected for pre-release) of the playlist entry.
        public var releaseDate: Date? { get }

        /// The title of the playlist entry.
        public var title: String { get }

        /// The URL for the playlist entry.
        public var url: URL? { get }

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: Playlist.Entry, b: Playlist.Entry) -> Bool

        /// A type representing the stable identity of the entity associated with
        /// an instance.
        @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 13.0, *)
        public typealias ID = MusicItemID

        /// Hashes the essential components of this value by feeding them into the
        /// given hasher.
        ///
        /// Implement this method to conform to the `Hashable` protocol. The
        /// components used for hashing must be the same as the components compared
        /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
        /// with each of these components.
        ///
        /// - Important: In your implementation of `hash(into:)`,
        ///   don't call `finalize()` on the `hasher` instance provided,
        ///   or replace it with a different instance.
        ///   Doing so may become a compile-time error in the future.
        ///
        /// - Parameter hasher: The hasher to use when combining the components
        ///   of this instance.
        public func hash(into hasher: inout Hasher)

        /// The hash value.
        ///
        /// Hash values are not guaranteed to be equal across different executions of
        /// your program. Do not save hash values to use during a future execution.
        ///
        /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
        ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
        ///   The compiler provides an implementation for `hashValue` for you.
        public var hashValue: Int { get }
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Playlist : MusicPropertyContainer {
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension Playlist : PlayableMusicItem {
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Playlist : MusicCatalogChartRequestable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Playlist : MusicCatalogSearchable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Playlist : FilterableMusicItem {

    /// The associated type that contains the set of playlist properties
    /// your app uses as a filter for a catalog resource request.
    public typealias FilterType = PlaylistFilter
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
extension Playlist : MusicLibraryAddable, MusicPlaylistAddable {
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension Playlist : MusicLibraryRequestable {

    /// The associated type that contains the playlist properties
    /// your app uses for a library request.
    public typealias LibraryFilter = LibraryPlaylistFilter

    /// The associated type that contains the set of playlist properties
    /// your app uses to sort results for a library request.
    public typealias LibrarySortProperties = LibraryPlaylistSortProperties
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension Playlist : MusicLibrarySectionRequestable {
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension Playlist : MusicLibrarySearchable {
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Playlist : MusicPersonalRecommendationItem {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Playlist : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Playlist : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Playlist {

    /// The available kinds of playlists.
    public enum Kind : Codable, Equatable, Hashable, Sendable {

        /// Indicates that the playlist was created by an Apple Music curator.
        case editorial

        /// Indicates that the playlist was created by an external curator.
        case external

        /// Indicates that the playlist is a personalized playlist for an Apple Music user.
        case personalMix

        /// Indicates that the playlist is a personalized Replay playlist for an Apple Music user.
        case replay

        /// Indicates that the playlist was created and shared by an Apple Music user.
        case userShared

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: Playlist.Kind, b: Playlist.Kind) -> Bool

        /// Encodes this value into the given encoder.
        ///
        /// If the value fails to encode anything, `encoder` will encode an empty
        /// keyed container in its place.
        ///
        /// This function throws an error if any values are invalid for the given
        /// encoder's format.
        ///
        /// - Parameter encoder: The encoder to write data to.
        public func encode(to encoder: any Encoder) throws

        /// Hashes the essential components of this value by feeding them into the
        /// given hasher.
        ///
        /// Implement this method to conform to the `Hashable` protocol. The
        /// components used for hashing must be the same as the components compared
        /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
        /// with each of these components.
        ///
        /// - Important: In your implementation of `hash(into:)`,
        ///   don't call `finalize()` on the `hasher` instance provided,
        ///   or replace it with a different instance.
        ///   Doing so may become a compile-time error in the future.
        ///
        /// - Parameter hasher: The hasher to use when combining the components
        ///   of this instance.
        public func hash(into hasher: inout Hasher)

        /// The hash value.
        ///
        /// Hash values are not guaranteed to be equal across different executions of
        /// your program. Do not save hash values to use during a future execution.
        ///
        /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
        ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
        ///   The compiler provides an implementation for `hashValue` for you.
        public var hashValue: Int { get }

        /// Creates a new instance by decoding from the given decoder.
        ///
        /// This initializer throws an error if reading from the decoder fails, or
        /// if the data read is corrupted or otherwise invalid.
        ///
        /// - Parameter decoder: The decoder to read data from.
        public init(from decoder: any Decoder) throws
    }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Playlist.Entry {

    /// An item that corresponds to an entry in a playlist.
    public enum Item : MusicItem, Equatable, Hashable, Identifiable, Sendable {

        /// An item that corresponds to a music video.
        case musicVideo(MusicVideo)

        /// An item that corresponds to a song.
        case song(Song)

        /// The unique identifier for the playlist entry item.
        public var id: MusicItemID { get }

        /// The artwork for the playlist entry’s item.
        public var artwork: Artwork? { get }

        /// The title of the album the playlist entry’s item appears on.
        public var albumTitle: String? { get }

        /// The artist’s name.
        public var artistName: String { get }

        /// The artist’s URL.
        public var artistURL: URL? { get }

        /// The rating of the content.
        ///
        /// A nil value means no rating is available for this playlist entry’s item.
        public var contentRating: ContentRating? { get }

        /// The duration of the playlist entry’s item.
        public var duration: TimeInterval? { get }

        /// The editorial notes for the playlist entry’s item.
        public var editorialNotes: EditorialNotes? { get }

        /// The names of the playlist entry’s item associated genres.
        public var genreNames: [String] { get }

        /// The date when the user last played the playlist entry’s item on this device.
        @available(macOS 14.0, macCatalyst 17.0, *)
        public var lastPlayedDate: Date? { get }

        /// The date when the user added the playlist entry’s item to the library.
        @available(macOS 14.0, macCatalyst 17.0, *)
        public var libraryAddedDate: Date? { get }

        /// The International Standard Recording Code (ISRC) for the playlist entry’s item.
        public var isrc: String? { get }

        /// The number of times the user played the playlist entry’s item.
        @available(macOS 14.0, macCatalyst 17.0, *)
        public var playCount: Int? { get }

        /// The parameters to use to play the playlist entry’s item.
        public var playParameters: PlayParameters? { get }

        /// The preview assets for the playlist entry’s item.
        public var previewAssets: [PreviewAsset]? { get }

        /// The release date of the playlist entry’s item.
        public var releaseDate: Date? { get }

        /// The title of the playlist entry’s item.
        public var title: String { get }

        /// The URL for the playlist entry’s item.
        public var url: URL? { get }

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: Playlist.Entry.Item, b: Playlist.Entry.Item) -> Bool

        /// A type representing the stable identity of the entity associated with
        /// an instance.
        @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 13.0, *)
        public typealias ID = MusicItemID

        /// Hashes the essential components of this value by feeding them into the
        /// given hasher.
        ///
        /// Implement this method to conform to the `Hashable` protocol. The
        /// components used for hashing must be the same as the components compared
        /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
        /// with each of these components.
        ///
        /// - Important: In your implementation of `hash(into:)`,
        ///   don't call `finalize()` on the `hasher` instance provided,
        ///   or replace it with a different instance.
        ///   Doing so may become a compile-time error in the future.
        ///
        /// - Parameter hasher: The hasher to use when combining the components
        ///   of this instance.
        public func hash(into hasher: inout Hasher)

        /// The hash value.
        ///
        /// Hash values are not guaranteed to be equal across different executions of
        /// your program. Do not save hash values to use during a future execution.
        ///
        /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
        ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
        ///   The compiler provides an implementation for `hashValue` for you.
        public var hashValue: Int { get }
    }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Playlist.Entry : MusicPropertyContainer {
}

@available(iOS 16.0, tvOS 16.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension Playlist.Entry : PlayableMusicItem {
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
extension Playlist.Entry : MusicLibraryAddable, MusicPlaylistAddable {
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Playlist.Entry : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension Playlist.Entry : MusicLibraryRequestable {

    /// The associated type that contains the playlist entry properties
    /// your app uses for a library request.
    public typealias LibraryFilter = LibraryPlaylistEntryFilter

    /// The associated type that contains the set of playlist entry properties
    /// your app uses to sort results for a library request.
    public typealias LibrarySortProperties = LibraryPlaylistEntrySortProperties
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Playlist.Entry : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Playlist.Entry.Item : MusicPropertyContainer {
}

@available(iOS 16.0, tvOS 16.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension Playlist.Entry.Item : PlayableMusicItem {
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Playlist.Entry.Item : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Playlist.Entry.Item : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// Playlist properties your app uses as a filter
/// for a catalog resource request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public protocol PlaylistFilter {

    /// The unique identifier for the playlist.
    var id: MusicItemID { get }
}

/// An object that represents a preview for resources.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct PreviewAsset : Equatable, Hashable, Sendable {

    /// The preview artwork for the associated preview music video.
    public let artwork: Artwork?

    /// The preview URL for the content.
    public let url: URL?

    /// The HLS preview URL for the content.
    public let hlsURL: URL?

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: PreviewAsset, b: PreviewAsset) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension PreviewAsset : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension PreviewAsset : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// A music item that represents a radio show.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
public struct RadioShow : MusicItem, Equatable, Hashable, Identifiable, Sendable {

    /// The unique identifier for the radio show.
    public let id: MusicItemID

    /// The radio show artwork.
    public var artwork: Artwork? { get }

    /// The notes about the radio show that appear in the Music catalog.
    public var editorialNotes: EditorialNotes? { get }

    /// The name of the host for the radio show.
    public var hostName: String? { get }

    /// The name of the radio show.
    public var name: String { get }

    /// The URL for the radio show.
    public var url: URL? { get }

    /// The radio show’s associated playlists.
    public var playlists: MusicItemCollection<Playlist>? { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: RadioShow, b: RadioShow) -> Bool

    /// A type representing the stable identity of the entity associated with
    /// an instance.
    @available(iOS 15.4, tvOS 15.4, watchOS 9.0, visionOS 1.0, macOS 12.3, *)
    public typealias ID = MusicItemID

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
extension RadioShow : MusicPropertyContainer {
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
extension RadioShow : MusicCatalogSearchable {
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
extension RadioShow : FilterableMusicItem {

    /// The associated type that contains the radio show properties
    /// your app uses as a filter for a catalog resource request.
    public typealias FilterType = RadioShowFilter
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
extension RadioShow : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
extension RadioShow : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// Radio Show properties your app uses as a filter for a catalog resource request.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
public protocol RadioShowFilter {

    /// The unique identifier for the radio show.
    var id: MusicItemID { get }
}

/// An item that represents an album, a playlist, or a station that the user has recently played.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public enum RecentlyPlayedMusicItem : MusicItem, Equatable, Hashable, Identifiable, Sendable {

    /// An item that corresponds to an album.
    case album(Album)

    /// An item that corresponds to a playlist.
    case playlist(Playlist)

    /// An item that corresponds to a station.
    case station(Station)

    /// The unique identifier of this item.
    public var id: MusicItemID { get }

    /// The artwork of this item.
    public var artwork: Artwork? { get }

    /// The parameters to use to play this item.
    public var playParameters: PlayParameters? { get }

    /// The title of this item.
    public var title: String { get }

    /// The subtitle of this item.
    public var subtitle: String? { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: RecentlyPlayedMusicItem, b: RecentlyPlayedMusicItem) -> Bool

    /// A type representing the stable identity of the entity associated with
    /// an instance.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 13.0, *)
    public typealias ID = MusicItemID

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension RecentlyPlayedMusicItem : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension RecentlyPlayedMusicItem : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

@available(iOS 16.0, tvOS 16.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension RecentlyPlayedMusicItem : PlayableMusicItem {
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension RecentlyPlayedMusicItem : MusicRecentlyPlayedRequestable {
}

/// A music item that represents a record label.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct RecordLabel : MusicItem, Equatable, Hashable, Identifiable, Sendable {

    /// The unique identifier for the record label.
    public let id: MusicItemID

    /// The record label’s artwork.
    public var artwork: Artwork? { get }

    /// An abbreviated description to show inline or when the record label
    /// appears alongside other content.
    public var shortDescription: String? { get }

    /// A description to show when the record label is prominently displayed.
    public var standardDescription: String? { get }

    /// The name of the record label.
    public var name: String { get }

    /// The URL for the record label.
    public var url: URL? { get }

    /// A collection of the most recent releases for the record label.
    public var latestReleases: MusicItemCollection<Album>? { get }

    /// A collection of top releases for the record label.
    public var topReleases: MusicItemCollection<Album>? { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: RecordLabel, b: RecordLabel) -> Bool

    /// A type representing the stable identity of the entity associated with
    /// an instance.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias ID = MusicItemID

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension RecordLabel : MusicPropertyContainer {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension RecordLabel : MusicCatalogSearchable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension RecordLabel : FilterableMusicItem {

    /// The associated type that contains the set of properties for record labels
    /// your app uses as a filter for a catalog resource request.
    public typealias FilterType = RecordLabelFilter
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension RecordLabel : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension RecordLabel : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// The set of record label properties your app uses as a filter
/// for a catalog resource request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public protocol RecordLabelFilter {

    /// The unique identifier for the record label.
    var id: MusicItemID { get }
}

/// A music item that represents a song.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct Song : MusicItem, Equatable, Hashable, Identifiable, Sendable {

    /// The unique identifier for the song.
    public let id: MusicItemID

    /// The artwork for the song.
    public var artwork: Artwork? { get }

    /// The title of the album the song appears on.
    public var albumTitle: String? { get }

    /// The artist’s name.
    public var artistName: String { get }

    /// The artist’s URL.
    public var artistURL: URL? { get }

    /// For classical music only, the name of the artist or composer to attribute to the song.
    public var attribution: String? { get }

    /// The variants that indicate the quality of audio available for the song.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
    public var audioVariants: [AudioVariant]? { get }

    /// The name of the song’s composer.
    public var composerName: String? { get }

    /// The rating of the content.
    ///
    /// A nil value means no rating is available for this song.
    public var contentRating: ContentRating? { get }

    /// The number of the disc the song appears on.
    public var discNumber: Int? { get }

    /// The duration of the song.
    public var duration: TimeInterval? { get }

    /// The editorial notes for the song.
    public var editorialNotes: EditorialNotes? { get }

    /// The names of the song’s associated genres.
    public var genreNames: [String] { get }

    /// A Boolean value that indicates whether the song has lyrics available in the catalog. If true, the song has lyrics available; otherwise, it doesn’t.
    public var hasLyrics: Bool { get }

    /// A Boolean value that indicates whether the song is
    /// an Apple Digital Master.
    /// 
    /// Apple Digital Masters start from 24-bit files and are 
    /// optimized to bring the best-sounding audio to Apple products.
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
    public var isAppleDigitalMaster: Bool? { get }

    /// The International Standard Recording Code (ISRC) for the song.
    public var isrc: String? { get }

    /// The date when the user last played the song on this device.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
    public var lastPlayedDate: Date? { get }

    /// The date when the user added the song to the library.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
    public var libraryAddedDate: Date? { get }

    /// For classical music only, the movement count of this song.
    public var movementCount: Int? { get }

    /// For classical music only, the movement name of this song.
    public var movementName: String? { get }

    /// For classical music only, the movement number of this song.
    public var movementNumber: Int? { get }

    /// The number of times the user played the song.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
    public var playCount: Int? { get }

    /// The parameters to use to play the song.
    public var playParameters: PlayParameters? { get }

    /// The preview assets for the song.
    public var previewAssets: [PreviewAsset]? { get }

    /// The release date (or expected prerelease date) for the song.
    public var releaseDate: Date? { get }

    /// The title of the song.
    public var title: String { get }

    /// The song’s number in the album’s track list.
    public var trackNumber: Int? { get }

    /// The URL for the song.
    public var url: URL? { get }

    /// For classical music only, the name of the associated work.
    public var workName: String? { get }

    /// The song’s associated albums.
    public var albums: MusicItemCollection<Album>? { get }

    /// The song’s associated artists.
    public var artists: MusicItemCollection<Artist>? { get }

    /// The song’s associated genres.
    public var genres: MusicItemCollection<Genre>? { get }

    /// The song’s associated station.
    public var station: Station? { get }

    /// The song’s composers.
    public var composers: MusicItemCollection<Artist>? { get }

    /// The song’s associated music videos.
    public var musicVideos: MusicItemCollection<MusicVideo>? { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: Song, b: Song) -> Bool

    /// A type representing the stable identity of the entity associated with
    /// an instance.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias ID = MusicItemID

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Song : MusicPropertyContainer {
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension Song : PlayableMusicItem {
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Song : MusicCatalogChartRequestable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Song : MusicCatalogSearchable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Song : FilterableMusicItem {

    /// The associated type that contains the set of song properties
    /// your app uses as a filter for a catalog resource request.
    public typealias FilterType = SongFilter
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
extension Song : MusicLibraryAddable, MusicPlaylistAddable {
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension Song : MusicLibraryRequestable {

    /// The associated type that contains the song properties
    /// your app uses for a library request.
    public typealias LibraryFilter = LibrarySongFilter

    /// The associated type that contains the set of song properties
    /// your app uses to sort results for a library request.
    public typealias LibrarySortProperties = LibrarySongSortProperties
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension Song : MusicLibrarySearchable {
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Song : MusicRecentlyPlayedRequestable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Song : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Song : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// Song properties your app uses as a filter for a catalog resource request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public protocol SongFilter {

    /// The unique identifier for the song.
    var id: MusicItemID { get }

    /// The International Standard Recording Code (ISRC) for the song.
    var isrc: String? { get }
}

/// A music item that represents a station.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public struct Station : MusicItem, Equatable, Hashable, Identifiable, Sendable {

    /// The unique identifier for the station.
    public let id: MusicItemID

    /// The station artwork.
    public var artwork: Artwork? { get }

    /// The rating of the content that potentially plays while playing the station.
    public var contentRating: ContentRating? { get }

    /// The duration of the stream.
    ///
    /// Live and programmed stations don’t have a duration.
    public var duration: TimeInterval? { get }

    /// The notes about the station that appear in the Music app.
    public var editorialNotes: EditorialNotes? { get }

    /// The episode number of the station.
    ///
    /// This value appears when the station represents an episode
    /// of a show or other content.
    public var episodeNumber: Int? { get }

    /// A Boolean value that indicates whether the station is live.
    public var isLive: Bool { get }

    /// The name of the station.
    public var name: String { get }

    /// The parameters to use to play the station.
    public var playParameters: PlayParameters? { get }

    /// The name of the entity that provides the station.
    public var stationProviderName: String? { get }

    /// The URL for the station.
    public var url: URL? { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: Station, b: Station) -> Bool

    /// A type representing the stable identity of the entity associated with
    /// an instance.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias ID = MusicItemID

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Station : MusicPropertyContainer {
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension Station : PlayableMusicItem {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Station : MusicCatalogSearchable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Station : FilterableMusicItem {

    /// The associated type that contains the set of station properties
    /// your app uses as a filter for a catalog resource request.
    public typealias FilterType = StationFilter
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Station : MusicPersonalRecommendationItem {
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Station : MusicRecentlyPlayedRequestable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Station : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Station : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

/// The set of station properties your app uses as a filter
/// for a catalog resource request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public protocol StationFilter {

    /// The unique identifier for the station.
    var id: MusicItemID { get }
}

/// An object your app uses to play music by controlling the Music app’s state.
///
/// The system music player employs the Music app on your behalf. 
/// When your app accesses the system music player for the first time,
/// it assumes the current Music app state and controls it as your app runs.
/// The shared state includes the following:
///  * Repeat mode (see ``MusicPlayer/RepeatMode``)
///  * Shuffle mode (see ``MusicPlayer/ShuffleMode``)
///  * Playback status (see ``MusicPlayer/PlaybackStatus``)
///
/// The system music player doesn’t share other aspects of the Music app’s
/// state. Music that’s playing continues to play when your app moves
/// to the background.
@available(iOS 15.0, tvOS 15.0, visionOS 1.0, *)
@available(watchOS, unavailable)
@available(macOS, unavailable)
public class SystemMusicPlayer : MusicPlayer {

    /// The shared system music player, which controls the Music app’s state.
    public static let shared: SystemMusicPlayer

    /// The playback queue for the system music player.
    public var queue: MusicPlayer.Queue

    @objc deinit
}

/// A section you can use to request items from the library grouped by title.
///
/// For example, when you perform a library sectioned request of albums,
/// the library sectioned response will contain albums grouped
/// by the first letter of their title, and the ``title`` property of this section
/// will be equal to that first letter.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
public struct TitledSection : Equatable, Hashable, Identifiable, Sendable {

    /// The title of the section.
    public let title: String

    /// The unique identifier for the titled section.
    public var id: MusicItemID { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: TitledSection, b: TitledSection) -> Bool

    /// A type representing the stable identity of the entity associated with
    /// an instance.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
    public typealias ID = MusicItemID

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension TitledSection : MusicLibrarySectionRequestable {
}

/// A music item that represents a track.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
public enum Track : MusicItem, Equatable, Hashable, Identifiable, Sendable {

    /// A track that corresponds to a song.
    case song(Song)

    /// A track that corresponds to a music video.
    case musicVideo(MusicVideo)

    /// The unique identifier for the track.
    public var id: MusicItemID { get }

    /// The artwork for the track.
    public var artwork: Artwork? { get }

    /// The title of the album the track appears on.
    public var albumTitle: String? { get }

    /// The artist’s name.
    public var artistName: String { get }

    /// The artist’s URL.
    public var artistURL: URL? { get }

    /// The rating of the content.
    ///
    /// A nil value means no rating is available for this track.
    public var contentRating: ContentRating? { get }

    /// The disc number of the track.
    public var discNumber: Int? { get }

    /// The duration of the track.
    public var duration: TimeInterval? { get }

    /// The editorial notes for the track.
    public var editorialNotes: EditorialNotes? { get }

    /// The names of the track’s associated genres.
    public var genreNames: [String] { get }

    /// The date when the user last played the track on this device.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
    public var lastPlayedDate: Date? { get }

    /// The date when the user added the track to the library.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
    public var libraryAddedDate: Date? { get }

    /// The International Standard Recording Code (ISRC) for the track.
    public var isrc: String? { get }

    /// The number of times the user played the track.
    @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
    public var playCount: Int? { get }

    /// The parameters to use to play the track.
    public var playParameters: PlayParameters? { get }

    /// The preview assets for the track.
    public var previewAssets: [PreviewAsset]? { get }

    /// The release date (or expected for pre-release) of the track.
    public var releaseDate: Date? { get }

    /// The title of the track.
    public var title: String { get }

    /// The track’s number in the album’s track list.
    public var trackNumber: Int? { get }

    /// The URL for the track.
    public var url: URL? { get }

    /// For classical music only, the name of the associated work.
    public var workName: String? { get }

    /// The track’s associated albums.
    public var albums: MusicItemCollection<Album>? { get }

    /// The track’s associated artists.
    public var artists: MusicItemCollection<Artist>? { get }

    /// The track’s associated genres.
    public var genres: MusicItemCollection<Genre>? { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: Track, b: Track) -> Bool

    /// A type representing the stable identity of the entity associated with
    /// an instance.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias ID = MusicItemID

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Track : MusicPropertyContainer {
}

@available(iOS 15.0, tvOS 15.0, visionOS 1.0, macOS 14.0, *)
@available(watchOS, unavailable)
extension Track : PlayableMusicItem {
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
extension Track : MusicLibraryAddable, MusicPlaylistAddable {
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension Track : MusicLibraryRequestable {

    /// The associated type that contains the track properties
    /// your app uses for a library request.
    public typealias LibraryFilter = LibraryTrackFilter

    /// The associated type that contains the set of track properties
    /// your app uses to sort results for a library request.
    public typealias LibrarySortProperties = LibraryTrackSortProperties
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension Track : MusicRecentlyPlayedRequestable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Track : Codable {

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: any Decoder) throws

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: any Encoder) throws
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Track : CustomStringConvertible, CustomDebugStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String { get }
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension Bool : MusicLibraryRequestFilterValueEquatable {
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, macOS 14.0, macCatalyst 17.0, *)
extension String : MusicLibraryRequestFilterValueEquatable {
}


// MARK: - SwiftUI Additions

import SwiftUI
import UIKit

// Available when SwiftUI is imported with MusicKit
/// A view that displays the image for a music item’s artwork.
///
/// You can create an artwork image with an instance of
/// <doc://com.apple.documentation/documentation/MusicKit/Artwork>.
///
/// While the artwork’s image data is loading, ``ArtworkImage``
/// automatically displays a placeholder with a solid color that matches the
/// <doc://com.apple.documentation/documentation/MusicKit/Artwork/backgroundColor>
/// property of the artwork to render.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
@MainActor @preconcurrency public struct ArtworkImage : View {

    /// Creates an instance with a specified width and height.
    ///
    /// This initializer derives the
    /// <doc://com.apple.documentation/documentation/Foundation/URL>
    /// for loading the artwork image from the 
    /// <doc://com.apple.documentation/documentation/MusicKit/Artwork>
    /// instance and the specified sizing parameters,
    /// as well as the display scale for the current environment.
    ///
    /// The loaded image and placeholder have constrained frames
    /// from these sizing parameters.
    nonisolated public init(_ artwork: Artwork, width: CGFloat, height: CGFloat)

    /// Creates an instance with a specified width.
    ///
    /// This initializer derives the
    /// <doc://com.apple.documentation/documentation/Foundation/URL>
    /// for loading the artwork image from the 
    /// <doc://com.apple.documentation/documentation/MusicKit/Artwork>
    /// instance and the specified sizing parameters,
    /// as well as the display scale for the current environment.
    ///
    /// The loaded image and placeholder have constrained frames
    /// from these sizing parameters.
    ///
    /// If you provide the width only, the artwork image calculates
    /// the height dimension as a proportional length according to
    /// the aspect ratio of the artwork.
    nonisolated public init(_ artwork: Artwork, width: CGFloat)

    /// Creates an instance with a specified height.
    ///
    /// This initializer derives the
    /// <doc://com.apple.documentation/documentation/Foundation/URL>
    /// for loading the artwork image from the 
    /// <doc://com.apple.documentation/documentation/MusicKit/Artwork>
    /// instance and the specified sizing parameters,
    /// as well as the display scale for the current environment.
    ///
    /// The loaded image and placeholder have constrained frames
    /// from these sizing parameters.
    ///
    /// If you provide the height only, the artwork image calculates
    /// the width dimension as a proportional length according to
    /// the aspect ratio of the artwork.
    nonisolated public init(_ artwork: Artwork, height: CGFloat)

    /// The content and behavior of the view.
    ///
    /// When you implement a custom view, you must implement a computed
    /// `body` property to provide the content for your view. Return a view
    /// that's composed of built-in views that SwiftUI provides, plus other
    /// composite views that you've already defined:
    ///
    ///     struct MyView: View {
    ///         var body: some View {
    ///             Text("Hello, World!")
    ///         }
    ///     }
    ///
    /// For more information about composing views and a view hierarchy,
    /// see <doc:Declaring-a-Custom-View>.
    @MainActor @preconcurrency public var body: some View { get }

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required ``View/body-swift.property`` property.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, macOS 12.0, *)
    public typealias Body = some View
}

// Available when SwiftUI is imported with MusicKit
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension ArtworkImage : Sendable {
}

// Available when SwiftUI is imported with MusicKit
/// A type for grouping other types for showing subscription offers
/// for Apple Music.
@available(iOS 15.0, macOS 12.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
public struct MusicSubscriptionOffer {
}

// Available when SwiftUI is imported with MusicKit
@available(iOS 15.0, macOS 12.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension MusicSubscriptionOffer {

    /// A representation of the entry point for the sheet with subscription
    /// offers for Apple Music.
    public struct Action : RawRepresentable, Equatable, Hashable, Sendable {

        /// Creates an action with the specified raw value.
        public init(_ rawValue: String)

        /// Creates an action with the specified raw value.
        public init(rawValue: String)

        /// The corresponding value of the raw type.
        ///
        /// A new instance initialized with `rawValue` will be equivalent to this
        /// instance. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     let selectedSize = PaperSize.Letter
        ///     print(selectedSize.rawValue)
        ///     // Prints "Letter"
        ///
        ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
        ///     // Prints "true"
        public let rawValue: String

        /// An action for inviting the user to subscribe to Apple Music.
        public static let subscribe: MusicSubscriptionOffer.Action

        /// The raw type that can be used to represent all values of the conforming
        /// type.
        ///
        /// Every distinct value of the conforming type has a corresponding unique
        /// value of the `RawValue` type, but there may be values of the `RawValue`
        /// type that don't have a corresponding value of the conforming type.
        @available(iOS 15.0, macOS 12.0, *)
        @available(tvOS, unavailable)
        @available(watchOS, unavailable)
        @available(visionOS, unavailable)
        public typealias RawValue = String
    }

    /// An identifier for the main message that the subscription offer sheet
    /// presents to the user.
    public struct MessageIdentifier : RawRepresentable, Equatable, Hashable, Sendable {

        /// Creates a message identifier with the specified raw value.
        public init(_ rawValue: String)

        /// Creates a message identifier with the specified raw value.
        public init(rawValue: String)

        /// The corresponding value of the raw type.
        ///
        /// A new instance initialized with `rawValue` will be equivalent to this
        /// instance. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     let selectedSize = PaperSize.Letter
        ///     print(selectedSize.rawValue)
        ///     // Prints "Letter"
        ///
        ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
        ///     // Prints "true"
        public let rawValue: String

        /// An identifier for the message that invites the user
        /// to join Apple Music.
        public static let join: MusicSubscriptionOffer.MessageIdentifier

        /// An identifier for the message that invites the user to add music
        /// to their library by subscribing to Apple Music.
        public static let addMusic: MusicSubscriptionOffer.MessageIdentifier

        /// An identifier for the message that invites the user to play music
        /// by subscribing to Apple Music.
        public static let playMusic: MusicSubscriptionOffer.MessageIdentifier

        /// The raw type that can be used to represent all values of the conforming
        /// type.
        ///
        /// Every distinct value of the conforming type has a corresponding unique
        /// value of the `RawValue` type, but there may be values of the `RawValue`
        /// type that don't have a corresponding value of the conforming type.
        @available(iOS 15.0, macOS 12.0, *)
        @available(tvOS, unavailable)
        @available(watchOS, unavailable)
        @available(visionOS, unavailable)
        public typealias RawValue = String
    }

    /// Options for loading subscription offers for Apple Music.
    public struct Options : Sendable {

        /// An action for the subscription offers entry point.
        ///
        /// Defaults to ``MusicSubscriptionOffer/Action/subscribe``.
        public var action: MusicSubscriptionOffer.Action

        /// An identifier for selecting the main message that
        /// the subscription offer sheet presents to the user.
        ///
        /// Defaults to ``MusicSubscriptionOffer/MessageIdentifier/join``.
        public var messageIdentifier: MusicSubscriptionOffer.MessageIdentifier

        /// An identifier for the music item the user is trying to access,
        /// which requires an active subscription.
        public var itemID: MusicItemID?

        /// An affiliate token for the Apple Services affiliate program.
        public var affiliateToken: String?

        /// A campaign token for the Apple Services affiliate program.
        public var campaignToken: String?

        /// The default set of options for loading subscription offers
        /// for Apple Music.
        public static let `default`: MusicSubscriptionOffer.Options

        /// Creates options for a subscription offer sheet with specific values
        /// for common properties.
        public init(action: MusicSubscriptionOffer.Action = .subscribe, messageIdentifier: MusicSubscriptionOffer.MessageIdentifier = .join, itemID: MusicItemID? = nil, affiliateToken: String? = nil, campaignToken: String? = nil)
    }
}

// Available when SwiftUI is imported with MusicKit
@available(iOS 15.0, macOS 12.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension MusicSubscriptionOffer.Action : CustomStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }
}

// Available when SwiftUI is imported with MusicKit
@available(iOS 15.0, macOS 12.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension MusicSubscriptionOffer.MessageIdentifier : CustomStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }
}

// Available when SwiftUI is imported with MusicKit
@available(iOS 15.0, macOS 12.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension MusicSubscriptionOffer.Options : Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: MusicSubscriptionOffer.Options, b: MusicSubscriptionOffer.Options) -> Bool
}

// Available when SwiftUI is imported with MusicKit
@available(iOS 15.0, macOS 12.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension MusicSubscriptionOffer.Options : Hashable {

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: In your implementation of `hash(into:)`,
    ///   don't call `finalize()` on the `hasher` instance provided,
    ///   or replace it with a different instance.
    ///   Doing so may become a compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    ///   The compiler provides an implementation for `hashValue` for you.
    public var hashValue: Int { get }
}

// Available when SwiftUI is imported with MusicKit
@available(iOS 15.0, macOS 12.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension MusicSubscriptionOffer.Options : CustomStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }
}

// Available when SwiftUI is imported with MusicKit
public typealias __NSConstantString = __NSConstantString_tag

// Available when SwiftUI is imported with MusicKit
public typealias __builtin_ms_va_list = UnsafeMutablePointer<CChar>

// Available when SwiftUI is imported with MusicKit
public typealias __builtin_va_list = UnsafeMutablePointer<CChar>

// Available when SwiftUI is imported with MusicKit
@available(iOS 15.0, macOS 12.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
extension View {

    /// Initiates the process of presenting a sheet with subscription offers
    /// for Apple Music when the `isPresented` binding is `true`.
    ///
    /// The example below displays a simple button that the user can activate
    /// to begin presenting subscription offers for Apple Music. The action
    /// handler of this button initiates the presentation of those offers
    /// by setting the `isShowingOffer` variable to `true`.
    ///
    ///     struct MusicSubscriptionOfferButton: View {
    ///         @State var isShowingOffer = false
    ///         var body: some View {
    ///             Button("Apple Music Subscription Offer") {
    ///                 isShowingOffer = true
    ///             }
    ///             .musicSubscriptionOffer(isPresented: $isShowingOffer)
    ///         }
    ///     }
    ///
    /// You can also configure the Apple Music subscription offer by
    /// creating an instance of `MusicSubscriptionOffer.Options`, setting
    /// relevant properties on it, and passing it to 
    /// `.musicSubscriptionOffer(…)`.
    /// For example, to present contextual offers that highlight a specific
    /// album, you can configure the subscription offer like the following:
    ///
    ///     struct MusicSubscriptionOfferButton: View {
    ///         var album: Album
    ///         @State var isShowingOffer = false
    ///         @State var offerOptions = MusicSubscriptionOffer.Options(
    ///             affiliateToken: "<affiliate_token>", 
    ///             campaignToken: "<campaign_token>"
    ///         )
    ///
    ///         var body: some View {
    ///             Button("Apple Music Subscription Offer") {
    ///                 offerOptions.itemID = album.id
    ///                 isShowingOffer = true
    ///             }
    ///             .musicSubscriptionOffer(
    ///                 isPresented: $isShowingOffer, 
    ///                 options: offerOptions
    ///             )
    ///         }
    ///     }
    ///
    /// The initial value of `offerOptions` includes relevant tokens
    /// (affiliate and campaign tokens) that allow you to receive compensation
    /// for referring new Apple Music subscribers. For more information,
    /// see this presentation of the
    /// [Apple Services Performance Partners Program](https://affiliate.itunes.apple.com/resources/).
    ///
    /// You may also set `isShowingOffer` to `false` to programmatically
    /// dismiss the subscription offer (or to abort its loading process).
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that you can set to
    ///     `true` to show a sheet with subscription offers for Apple Music.
    ///   - options: Options to use for loading the subscription offer for
    ///     Apple Music.
    ///   - onLoadCompletion: The function to call upon completing the initial
    ///     loading process for this subscription offer. The subscription
    ///     offer UI becomes visible when it calls this function with the
    ///     error argument as `nil`. If there is an error in the
    ///     loading process, the subscription offer calls this function with
    ///     a non-`nil` error, and it resets the `isPresented` binding
    ///     to `false`.
    nonisolated public func musicSubscriptionOffer(isPresented: Binding<Bool>, options: MusicSubscriptionOffer.Options = .default, onLoadCompletion: @escaping ((any Error)?) -> Void = { _ in }) -> some View

}