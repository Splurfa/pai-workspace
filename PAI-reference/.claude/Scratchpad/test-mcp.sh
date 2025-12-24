#!/bin/bash

claude_dir="/Users/daniel/Projects/PAI/.claude"

mcp_json_data=$(jq -r '.mcpServers | keys | join(" "), length' "$claude_dir/.mcp.json" 2>/dev/null)
echo "Full data: [$mcp_json_data]"

mcp_json_names=$(echo "$mcp_json_data" | head -1)
echo "Names: [$mcp_json_names]"

mcp_json_count=$(echo "$mcp_json_data" | tail -1)
echo "Count: [$mcp_json_count]"

echo "Test loop:"
for mcp in $mcp_json_names; do
    echo "  - $mcp"
done
