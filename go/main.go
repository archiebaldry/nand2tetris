package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"
	"regexp"
	"strings"
)

type chip struct {
	nandCount int
	parts map[string]int
}

func main() {
	chipNameRegexp := regexp.MustCompile(`CHIP\s+([A-Z]\w*)\s*{`)
	chipPartsRegexp := regexp.MustCompile(`\s*([A-Z]\w*)\(.*\);`)
	paths := getPaths("../projects")
	// fmt.Println(paths)
	// name {
	//   nandCount: 0
	//   parts: {
	//     "Nand": 1
	//   }
	// }
	chips := map[string]chip{}
	for _, path := range paths {
		content, err := ioutil.ReadFile(path)
		if err != nil {
			fmt.Println(path + ":", err)
			continue
		}
		chipName := string(chipNameRegexp.FindSubmatch(content)[1])
		chipParts := map[string]int{}
		matches := chipPartsRegexp.FindAllSubmatch(content, -1)
		for _, match := range matches {
			partName := string(match[1])
			if _, ok := chipParts[partName]; ok {
				chipParts[partName] += 1
			} else {
				chipParts[partName] = 1
			}
		}
		if len(chipParts) > 0 {
			chips[chipName] = chip{0, chipParts}
		}
	}
	for name, chipCopy := range chips {
		chipCopy.nandCount = getNandCount(chips, name)
		chips[name] = chipCopy
	}
	for name, chip := range chips {
		fmt.Printf("%s: %+v\n", name, chip)
	}
}

func getNandCount(chips map[string]chip, name string) int {
	count := 0
	chip := chips[name]
	if chip.nandCount != 0 {
		return chip.nandCount
	}
	for partName, partCount := range chip.parts {
		if partName == "Nand" {
			count += 1 * partCount
		} else {
			count += getNandCount(chips, partName) * partCount
		}
	}
	return count
}

func getPaths(root string) []string {
	var paths []string
	err := filepath.Walk(root,
		func(path string, info os.FileInfo, err error) error {
			if err != nil {
				return err
			}
			name := info.Name()
			if strings.HasSuffix(name, ".hdl") {
				paths = append(paths, path)
			}
			return nil
		})
	if err != nil {
		fmt.Println(err)
	}
	return paths
}
