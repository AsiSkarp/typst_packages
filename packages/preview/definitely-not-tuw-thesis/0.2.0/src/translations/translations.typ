#import "@preview/linguify:0.4.2": linguify, set-database

#let set-defaults = (obj, keys, default) => {
  // for each key, sets default value if key does not exist
  for key in keys {
    obj.insert(key, obj.at(key, default: default))
  }
  return obj
}

#let init-translations = (additional-translations) => {
  let lang-data = toml("translations.toml")

  for (key, value) in additional-translations {
    if value != none {
      value = set-defaults(value, ("en", "de"), "")
      lang-data.lang.en.insert(key, value.en)
      lang-data.lang.de.insert(key, value.de)
    }
  }
  set-database(lang-data);
}

#let translate = key => {
  linguify(key)
}
