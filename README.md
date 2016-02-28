# zebra
斑马

User update
curl  -X PATCH --header "Authorization: Token token=#{open_id}" -d "user[cell]=18592931254&name=xxxxxx" http://localhost:3000/api/users/{#user.id}

url:    http://localhost:3000/api/users/{user.id}
params:
        {
          user:
          {
            name: "xxxxxx",
            cell: "foobar@example.com",
            image: "data:image/png;base64,xxxxxxx"
          }
        }
