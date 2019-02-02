
Rails.configuration.stripe = {
    :publishable_key => "pk_test_GhLHT0qhavwwbLgMl1a9AKAv",
    :secret_key      => "sk_test_JJnuT3sawozWAuqkDJLW5r3e"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]