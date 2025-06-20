import * as monaco from 'monaco-editor';

export function registerSnortLanguage() {
  monaco.languages.register({ id: 'snort' });

  monaco.languages.setMonarchTokensProvider('snort', {
    tokenizer: {
      root: [
        // Rule actions
        [/\b(alert|drop|block|log|pass|react|reject|rewrite)\b/, 'action'],

        // Protocols and services
        [/\b(ip|icmp|tcp|udp|http|smtp|ssl)\b/, 'protocol'],

        // IP addresses, $VARS, port numbers
        [/\$[A-Z_]+/, 'address'],
        [/\b(any|\d+)\b/, 'address'],

        // Rule option keys
        [/\b(msg|flow|content|service|sid|rev|file_data|classtype|metadata|reference|priority)\b(?=\s*:)/, 'option'],

        // String values (quoted)
        [/".*?"/, 'string'],

        // Comments
        [/#.*$/, 'comment'],
        [/\/\*/, { token: 'comment', next: '@comment' }],
      ],

      comment: [
        [/[^\/*]+/, 'comment'],
        [/\/\*/, 'comment', '@push'],
        [/\*\//, 'comment', '@pop'],
        [/[\/*]/, 'comment']
      ],
    }
  });

  monaco.editor.defineTheme('vs-dark-snort', {
    base: 'vs-dark',
    inherit: true,
    rules: [
      { token: 'action', foreground: 'e06c75' },   // red
      { token: 'protocol', foreground: 'e5c07b' }, // yellow
      { token: 'address', foreground: '61afef' },  // blue
      { token: 'option', foreground: 'd19a66' },   // orange
      { token: 'string', foreground: '98c379' },   // green
      { token: 'comment', foreground: '5c6370', fontStyle: 'italic' },
    ],
    colors: {
      'editor.background': '#1e1e1e',
      'editorLineNumber.foreground': '#555',
    }
  });
}
