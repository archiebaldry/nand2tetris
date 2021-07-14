package main

import (
	"github.com/stretchr/testify/require"
	"testing"
)

func TestGetNandCount(t *testing.T) {
	chips := map[string]chip{
		"Nand": chip{
			nandCount: 1,
		},
		"Test": chip{
			nandCount: 25,
			parts: map[string]int{
				"Nand": 25,
			},
		},
		"Test2": chip{
			nandCount: 0,
			parts: map[string]int{
				"Nand": 2,
				"Test": 3,
			},
		},
	}
	want := 77
	got := getNandCount(chips, "Test2")
	require.Equal(t, want, got)
}
