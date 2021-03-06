context("Generating JWT headers")

test_that("Headers work for hmac", {
  key <- charToRaw("SuperSecret")
  jwt <- jwt_encode_hmac(jwt_claim(test = "test"), secret = key, header = list(test = "test"))
  strings <- strsplit(jwt, ".", fixed = TRUE)[[1]]
  expect_true(fromJSON(rawToChar(base64url_decode(strings[1])))$test == "test")
})

test_that("Headers work for sig", {
  mykey <- openssl::rsa_keygen()
  pubkey <- as.list(mykey)$pubkey
  jwt <- jwt_encode_sig(jwt_claim(test = "test"), mykey, header = list(test = "test"))
  strings <- strsplit(jwt, ".", fixed = TRUE)[[1]]
  expect_true(fromJSON(rawToChar(base64url_decode(strings[1])))$test == "test")
})
