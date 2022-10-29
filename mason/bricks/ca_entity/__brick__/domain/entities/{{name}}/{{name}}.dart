class {{name.pascalCase()}} { {{#variables}}
  {{type}} {{name}};{{/variables}}

  {{name.pascalCase()}}({ {{#variables}}
    this.{{name}},{{/variables}}
  });
}
