module Model.PostsConfig exposing (Change(..), PostsConfig, SortBy(..), applyChanges, defaultConfig, filterPosts, sortFromString, sortOptions, sortToCompareFn, sortToString)

import Html.Attributes exposing (scope)
import Model.Post exposing (Post)
import Time


type SortBy
    = Score
    | Title
    | Posted
    | None


sortOptions : List SortBy
sortOptions =
    [ Score, Title, Posted, None ]


sortToString : SortBy -> String
sortToString sort =
    case sort of
        Score ->
            "Score"

        Title ->
            "Title"

        Posted ->
            "Posted"

        None ->
            "None"


{-|

    sortFromString "Score" --> Just Score

    sortFromString "Invalid" --> Nothing

    sortFromString "Title" --> Just Title

-}
sortFromString : String -> Maybe SortBy
sortFromString str =
    case str of
        "Score" ->
            Just Score

        "Title" ->
            Just Title

        "Posted" ->
            Just Posted

        "None" ->
            Just None

        _ ->
            Nothing

sortToCompareFn : SortBy -> (Post -> Post -> Order)
sortToCompareFn sort =
    case sort of
        Score ->
            \a b -> compare b.score a.score

        Title ->
            \a b -> compare a.title b.title

        Posted ->
            \a b -> compare (Time.posixToMillis b.time) (Time.posixToMillis a.time)

        None ->
            \_ _ -> EQ

type alias PostsConfig =
    { postsToFetch : Int
    , postsToShow : Int
    , sortBy : SortBy
    , showJobs : Bool
    , showTextOnly : Bool
    }


defaultConfig : PostsConfig
defaultConfig =
    PostsConfig 50 10 None False True


{-| A type that describes what option changed and how
-}
type Change
    = ChangePostsToShow Int
    | ChangeSortBy String
    | ChangeShowJobs Bool
    | ChangeShowTextOnly Bool




{-| Given a change and the current configuration, return a new configuration with the changes applied
-}
applyChanges : Change -> PostsConfig -> PostsConfig
applyChanges change cfg =
    case change of
        ChangePostsToShow n ->
            { cfg | postsToShow = n }

        ChangeSortBy str ->
            case sortFromString str of
                Just s ->
                    { cfg | sortBy = s }

                Nothing ->
                    cfg

        ChangeShowJobs b ->
            { cfg | showJobs = b }

        ChangeShowTextOnly b ->
            { cfg | showTextOnly = b }



{-| Given the configuration and a list of posts, return the relevant subset of posts according to the configuration

Relevant local functions:

  - sortToCompareFn

Relevant library functions:

  - List.sortWith

-}
filterPosts : PostsConfig -> List Post -> List Post
filterPosts cfg posts =
    let
        filtered1 =
            if cfg.showTextOnly then
                posts
            else
                List.filter (\p -> p.url /= Nothing) posts

        filtered2 =
            if cfg.showJobs then
                filtered1
            else
                List.filter (\p -> p.type_ /= "job") filtered1

        sorted =
            List.sortWith (sortToCompareFn cfg.sortBy) filtered2
    in
    List.take cfg.postsToShow sorted