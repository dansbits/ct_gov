# CtGov

This gem is intended as a client for the ClinicalTrials.gov api. It primarily provides basic search and study retrieval methods and wrapper classes for the response which provide some data cleaning and formatting (e.g. stripping white space, converting date strings to dates, etc.)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ct_gov'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ct_gov

## Usage

### Get an individual study
You can fetch a study using it's nct id like this:
```
study = CtGov.find_by_nctid("NCT01914315")
study.nctid         # => "NCT01914315"
study.study_type    # => "Interventional"
```

### Search for studies
Or you can search for a list of studies like so:
```
search_results = CtGov.search({ term: "diabetes" })

# each item is a search result, not a study
# for the full study you'll have to do a subsequent
# CtGov::find_by_nctid
search_results.each { |r| print r.nct_id }

page2 = search_results.next_page    # the results are paginated
```
The hash parameter for the search method will take any key/value that is accepted as a url parameter in the clinicaltrials.gov advanced search here: https://clinicaltrials.gov/ct2/search/advanced

The best way to figure out what you want is to play with the search in the UI. Then automate.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ct_gov/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
