# frozen_string_literal: true

USERS_JSON = [{ "first_name": 'FirstName1', "last_name": 'LastName1', "full_name": 'FirstName1 LastName1', "country": { "name": 'India' }, "houses": [{ "house_tag": 'ha--1', "rooms_names": 'room1,room2,room3' }, { "house_tag": 'hb--2', "rooms_names": 'room1,room2,room3' }] }, { "last_name": 'LastName2', "first_name": 'FirstName2', "full_name": 'FirstName2 LastName2', "country": { "name": 'India' }, "houses": [{ "house_tag": 'hp--1', "rooms_names": 'room1,room2,room3' }, { "house_tag": 'hq--2', "rooms_names": 'room1,room2,room3' }, { "house_tag": 'hr--3', "rooms_names": 'room1,room2,room3' }] }].freeze
USER_JSON = { "first_name": 'FirstName', "last_name": 'LastName', "full_name": 'FirstName LastName', "country": { "name": 'India' }, "houses": {} }.freeze
USER_WITH_HOUSES_JSON = { "last_name": 'LastName', "first_name": 'FirstName', "full_name": 'FirstName LastName', "country": { "name": 'India' }, "houses": [{ "house_tag": 'ha--1', "rooms_names": 'room1,room2,room3' }] }.freeze

USER_XML = <<~XML
  <user>
    <first-name>FirstName</first-name>
    <last-name>LastName</last-name>
    <full-name>FirstName LastName</full-name>
    <country>
      <name>India</name>
    </country>
    <houses>
    </houses>
  </user>
XML
USER_WITH_HOUSES_XML = <<~XML
  <user>
    <first-name>FirstName</first-name>
    <last-name>LastName</last-name>
    <full-name>FirstName LastName</full-name>
    <country>
      <name>India</name>
    </country>
    <houses type="array">
      <house>
        <house-tag>ha--1</house-tag>
        <rooms-names>room1,room2,room3</rooms-names>
      </house>
    </houses>
  </user>
XML
