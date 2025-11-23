module View.Posts exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (href)
import Html.Events
import Model exposing (Msg(..))
import Model.Post exposing (Post)
import Model.PostsConfig exposing (Change(..), PostsConfig, SortBy(..), filterPosts, sortFromString, sortOptions, sortToCompareFn, sortToString)
import Time
import Util.Time


{-| Show posts as a HTML [table](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/table)

Relevant local functions:

  - Util.Time.formatDate
  - Util.Time.formatTime
  - Util.Time.formatDuration (once implemented)
  - Util.Time.durationBetween (once implemented)

Relevant library functions:

  - [Html.table](https://package.elm-lang.org/packages/elm/html/latest/Html#table)
  - [Html.tr](https://package.elm-lang.org/packages/elm/html/latest/Html#tr)
  - [Html.th](https://package.elm-lang.org/packages/elm/html/latest/Html#th)
  - [Html.td](https://package.elm-lang.org/packages/elm/html/latest/Html#td)

-}
postTable : PostsConfig -> Time.Posix -> List Post -> Html Msg
postTable cfg now posts =
    let
        headerRow =
            Html.tr []
                [ Html.th [] [ text "score" ]
                , Html.th [] [ text "title" ]
                , Html.th [] [ text "type" ]
                , Html.th [] [ text "posted" ]
                , Html.th [] [ text "link" ]
                ]

        viewRow post =
            let
                absTime =
                    Util.Time.formatTime Time.utc post.time

                rel =
                    case Util.Time.durationBetween post.time now of
                        Just d ->
                            " (" ++ Util.Time.formatDuration d ++ ")"

                        Nothing ->
                            ""
            in
            Html.tr []
                [ Html.td [ Html.Attributes.class "post-score" ]
                    [ text (String.fromInt post.score) ]

                , Html.td [ Html.Attributes.class "post-title" ]
                    [ text post.title ]

                , Html.td [ Html.Attributes.class "post-type" ]
                    [ text post.type_ ]

                , Html.td [ Html.Attributes.class "post-time" ]
                    [ text (absTime ++ rel) ]

                , Html.td [ Html.Attributes.class "post-url" ]
                    [ case post.url of
                        Just u ->
                            Html.a [ href u ] [ text u ]

                        Nothing ->
                            text ""
                      ]
                ]
    in
    Html.table [] (headerRow :: List.map viewRow posts)


{-| Show the configuration options for the posts table

Relevant functions:

  - [Html.select](https://package.elm-lang.org/packages/elm/html/latest/Html#select)
  - [Html.option](https://package.elm-lang.org/packages/elm/html/latest/Html#option)
  - [Html.input](https://package.elm-lang.org/packages/elm/html/latest/Html#input)
  - [Html.Attributes.type\_](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#type_)
  - [Html.Attributes.checked](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#checked)
  - [Html.Attributes.selected](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#selected)
  - [Html.Events.onCheck](https://package.elm-lang.org/packages/elm/html/latest/Html-Events#onCheck)
  - [Html.Events.onInput](https://package.elm-lang.org/packages/elm/html/latest/Html-Events#onInput)

-}
postsConfigView : PostsConfig -> Html Msg
postsConfigView cfg =
    let
        postsPerPageSelect =
            Html.select
                [ Html.Attributes.id "select-posts-per-page"
                , Html.Events.onInput
                    (\v ->
                        ConfigChanged
                            (ChangePostsToShow
                                (String.toInt v |> Maybe.withDefault cfg.postsToShow)
                            )
                    )
                ]
                [ Html.option [ Html.Attributes.selected (cfg.postsToShow == 10) ] [ text "10" ]
                , Html.option [ Html.Attributes.selected (cfg.postsToShow == 25) ] [ text "25" ]
                , Html.option [ Html.Attributes.selected (cfg.postsToShow == 50) ] [ text "50" ]
                ]


        sortSelect =
            Html.select
                [ Html.Attributes.id "select-sort-by"
                , Html.Events.onInput (\v -> ConfigChanged (ChangeSortBy v))
                ]
                (List.map
                    (\opt ->
                        Html.option
                            [ Html.Attributes.selected (sortToString cfg.sortBy == sortToString opt) ]
                            [ text (sortToString opt) ]
                    )
                    sortOptions
                )


        showJobsCheckbox =
            Html.label []
                [ Html.input
                    [ Html.Attributes.type_ "checkbox"
                    , Html.Attributes.id "checkbox-show-job-posts"
                    , Html.Attributes.checked cfg.showJobs
                    , Html.Events.onCheck (\b -> ConfigChanged (ChangeShowJobs b))
                    ]
                    []
                , text "Show job posts"
                ]


        showTextOnlyCheckbox =
            Html.label []
                [ Html.input
                    [ Html.Attributes.type_ "checkbox"
                    , Html.Attributes.id "checkbox-show-text-only-posts"
                    , Html.Attributes.checked cfg.showTextOnly
                    , Html.Events.onCheck (\b -> ConfigChanged (ChangeShowTextOnly b))
                    ]
                    []
                , text "Show text only posts"
                ]
    in
    div []
        [ postsPerPageSelect
        , sortSelect
        , showJobsCheckbox
        , showTextOnlyCheckbox
        ]