module TreeSitter.Verilog
( tree_sitter_verilog
, getNodeTypesPath
, getTestCorpusDir
) where

import Foreign.Ptr
import TreeSitter.Language
import Paths_tree_sitter_verilog

foreign import ccall unsafe "vendor/tree-sitter-verilog/src/parser.c tree_sitter_verilog" tree_sitter_verilog :: Ptr Language

getNodeTypesPath :: IO FilePath
getNodeTypesPath = getDataFileName "vendor/tree-sitter-verilog/src/node-types.json"

getTestCorpusDir :: IO FilePath
getTestCorpusDir = getDataFileName "vendor/tree-sitter-verilog/test/corpus"
