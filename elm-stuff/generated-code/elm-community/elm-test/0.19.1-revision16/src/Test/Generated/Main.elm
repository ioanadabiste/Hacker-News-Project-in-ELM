module Test.Generated.Main exposing (main)

import Example
import ExampleTests.CursorTests
import ExampleTests.ModelPostIdsTests
import ExampleTests.ModelPostsConfigTests
import ExampleTests.UtilTimeTests
import MainTests
import PostsConfigTests
import PostsViewTests
import PostTests
import SimulatedEffect
import TestData
import TestUtils

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    Test.Runner.Node.run
        { runs = 100
        , report = ConsoleReport Monochrome
        , seed = 376158560164992
        , processes = 16
        , globs =
            []
        , paths =
            [ "D:\\PF\\proiect bun\\tests\\Example.elm"
            , "D:\\PF\\proiect bun\\tests\\ExampleTests\\CursorTests.elm"
            , "D:\\PF\\proiect bun\\tests\\ExampleTests\\ModelPostIdsTests.elm"
            , "D:\\PF\\proiect bun\\tests\\ExampleTests\\ModelPostsConfigTests.elm"
            , "D:\\PF\\proiect bun\\tests\\ExampleTests\\UtilTimeTests.elm"
            , "D:\\PF\\proiect bun\\tests\\MainTests.elm"
            , "D:\\PF\\proiect bun\\tests\\PostsConfigTests.elm"
            , "D:\\PF\\proiect bun\\tests\\PostsViewTests.elm"
            , "D:\\PF\\proiect bun\\tests\\PostTests.elm"
            , "D:\\PF\\proiect bun\\tests\\SimulatedEffect.elm"
            , "D:\\PF\\proiect bun\\tests\\TestData.elm"
            , "D:\\PF\\proiect bun\\tests\\TestUtils.elm"
            ]
        }
        [ ( "Example"
          , [ Test.Runner.Node.check Example.suite
            ]
          )
        , ( "ExampleTests.CursorTests"
          , [ Test.Runner.Node.check ExampleTests.CursorTests.suite
            ]
          )
        , ( "ExampleTests.ModelPostIdsTests"
          , [ Test.Runner.Node.check ExampleTests.ModelPostIdsTests.suite
            ]
          )
        , ( "ExampleTests.ModelPostsConfigTests"
          , [ Test.Runner.Node.check ExampleTests.ModelPostsConfigTests.suite
            ]
          )
        , ( "ExampleTests.UtilTimeTests"
          , [ Test.Runner.Node.check ExampleTests.UtilTimeTests.suite
            ]
          )
        , ( "MainTests"
          , [ Test.Runner.Node.check MainTests.suite
            ]
          )
        , ( "PostsConfigTests"
          , [ Test.Runner.Node.check PostsConfigTests.suite
            ]
          )
        , ( "PostsViewTests"
          , [ Test.Runner.Node.check PostsViewTests.currentTime
            , Test.Runner.Node.check PostsViewTests.selectShowJobPostsCheckbox
            , Test.Runner.Node.check PostsViewTests.selectElementContainingShowJobPostsCheckbox
            , Test.Runner.Node.check PostsViewTests.selectShowTextPostsCheckbox
            , Test.Runner.Node.check PostsViewTests.selectElementContainingShowTextPostsCheckbox
            , Test.Runner.Node.check PostsViewTests.suite
            ]
          )
        , ( "PostTests"
          , [ Test.Runner.Node.check PostTests.requiredFields
            , Test.Runner.Node.check PostTests.fields
            , Test.Runner.Node.check PostTests.fieldNames
            , Test.Runner.Node.check PostTests.completePost
            , Test.Runner.Node.check PostTests.suite
            ]
          )
        , ( "SimulatedEffect"
          , [ Test.Runner.Node.check SimulatedEffect.start
            , Test.Runner.Node.check SimulatedEffect.fromLoadedState
            ]
          )
        , ( "TestData"
          , [ Test.Runner.Node.check TestData.posts
            , Test.Runner.Node.check TestData.allPosts
            , Test.Runner.Node.check TestData.textPosts
            , Test.Runner.Node.check TestData.jobPosts
            ]
          )
        , ( "TestUtils"
          , []
          )
        ]