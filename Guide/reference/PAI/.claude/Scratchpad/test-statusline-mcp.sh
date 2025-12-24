#!/bin/bash

claude_dir="/Users/daniel/Projects/PAI/.claude"

# Count MCPs from both settings.json and .mcp.json
mcp_names_raw=""
mcps_count=0

echo "=== Testing MCP Counting Logic ==="

# Check settings.json for .mcpServers (legacy)
if [ -f "$claude_dir/settings.json" ]; then
    mcp_data=$(jq -r '.mcpServers | keys | join(" "), length' "$claude_dir/settings.json" 2>/dev/null)
    echo "settings.json mcp_data: [$mcp_data]"
    if [ -n "$mcp_data" ] && [ "$mcp_data" != "null" ]; then
        mcp_names_raw=$(echo "$mcp_data" | head -1)
        mcps_count=$(echo "$mcp_data" | tail -1)
        echo "  Extracted names: [$mcp_names_raw]"
        echo "  Extracted count: [$mcps_count]"
    else
        echo "  No MCPs in settings.json (data was empty or null)"
    fi
fi

# Check .mcp.json (current Claude Code default)
if [ -f "$claude_dir/.mcp.json" ]; then
    mcp_json_data=$(jq -r '.mcpServers | keys | join(" "), length' "$claude_dir/.mcp.json" 2>/dev/null)
    echo ".mcp.json mcp_json_data: [$mcp_json_data]"
    if [ -n "$mcp_json_data" ] && [ "$mcp_json_data" != "null" ]; then
        mcp_json_names=$(echo "$mcp_json_data" | head -1)
        mcp_json_count=$(echo "$mcp_json_data" | tail -1)
        echo "  Extracted names: [$mcp_json_names]"
        echo "  Extracted count: [$mcp_json_count]"

        # Combine with settings.json results
        if [ -n "$mcp_names_raw" ]; then
            mcp_names_raw="$mcp_names_raw $mcp_json_names"
        else
            mcp_names_raw="$mcp_json_names"
        fi
        mcps_count=$((mcps_count + mcp_json_count))
        echo "  Combined names: [$mcp_names_raw]"
        echo "  Combined count: [$mcps_count]"
    else
        echo "  No MCPs in .mcp.json (data was empty or null)"
    fi
fi

echo ""
echo "=== Final Results ==="
echo "mcp_names_raw: [$mcp_names_raw]"
echo "mcps_count: [$mcps_count]"
