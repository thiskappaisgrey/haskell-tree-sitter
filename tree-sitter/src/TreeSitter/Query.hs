{-# LANGUAGE DeriveGeneric, GeneralizedNewtypeDeriving, RankNTypes, ScopedTypeVariables #-}
{-# OPTIONS_GHC -funbox-strict-fields #-}
module TreeSitter.Query
( Query
  , QueryError
  , ts_query_new
  , ts_query_delete
  , ts_query_pattern_count
  , ts_query_capture_count
  , ts_query_string_count
  , ts_query_start_byte_for_pattern
) where
import Foreign
import Foreign.C
import GHC.Generics
import TreeSitter.Language
import TreeSitter.Node
-- import TreeSitter.

-- | This type is uninhabited and used only for type safety within 'Ptr' values.

-- TODO this might be a bit harder because I need to figure out how many bytes the query struct takes..
data Query
data QueryError
data QueryCursor

-- TODO query capture and stuff might require a storable instance..
-- might want to move the "Struct" definition to a different file so Query can use it.
data QueryCapture = QueryCapture !TSNode !Word32
--                           id      index    count    
data QueryMatch = QueryMatch !Word32 !Word32 !Word32 !(Ptr ())
foreign import ccall safe "ts_query_new" ts_query_new :: Ptr Language -> CString -> Int -> Ptr Int -> Ptr QueryError -> IO (Ptr Query)
foreign import ccall safe "ts_query_delete" ts_query_delete :: Ptr Query -> IO ()

foreign import ccall safe "ts_query_pattern_count" ts_query_pattern_count :: Ptr Query -> IO Int
foreign import ccall safe "ts_query_capture_count" ts_query_capture_count :: Ptr Query -> IO Int
foreign import ccall safe "ts_query_string_count" ts_query_string_count :: Ptr Query -> IO Int

foreign import ccall safe "ts_query_start_byte_for_pattern" ts_query_start_byte_for_pattern :: Ptr Query -> Int -> IO Int

-- TODO also check the rust bindings for usage / inspiration as well
-- TODO figure out how to write the rest of these bindings....

-- TODO maybe I can write a bridge function in bridge.c to just yield all of the query matches..?
