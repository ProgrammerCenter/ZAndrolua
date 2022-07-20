package com.zajt;
import java.util.*;
public class javaListTools extends MainjavaTools
{

	static   public <T> List<List<T>> cartesianProduct(T[]... sets)
	{
        if (sets == null || sets.length == 0)
		{
            return Collections.emptyList();
        }
        int total = 1;
		
        //声明进位指针cIndex
        int cIndex = sets.length - 1;
        //声明counterMap(角标 - counter)
        int[] counterMap = new int[sets.length];
        for (int i = 0; i < sets.length; i++)
		{
            counterMap[i] = 0;
            total *= (sets[i] == null || sets[i].length == 0 ? 1 : sets[i].length);
        }
        List<List<T>> rt = new ArrayList<>(total);
        //开始求笛卡尔积
        while (cIndex >= 0)
		{
            List<T> element = new ArrayList<>(sets.length);
            for (int j = 0; j < sets.length; j++)
			{
                T[] set = sets[j];
                //忽略空集
                if (set != null && set.length > 0)
				{
                    element.add(set[counterMap[j]]);
                }
                //从末位触发指针进位
                if (j == sets.length - 1)
				{
                    if (set == null || ++counterMap[j] > set.length - 1)
					{
                        //重置指针
                        counterMap[j] = 0;
                        //进位
                        int cidx = j;
                        while (--cidx >= 0)
						{
                            //判断如果刚好前一位也要进位继续重置指针进位
                            if (sets[cidx] == null || ++counterMap[cidx] > sets[cidx].length - 1)
							{
                                counterMap[cidx] = 0;
                                continue;
                            }
                            break;
                        }
                        if (cidx < cIndex)
						{
                            //移动进位指针
                            cIndex = cidx;
                        }
                    }
                }
            }
            if (element.size() > 0)
			{
                rt.add(element);
            }
        }
		
        return rt;
    }

	/**
     * 从有值的list中取交集
     * @param lists
     * @return
     */
    public static List<String> getIntersection_b(List<List<String>> lists)
	{
        if (lists == null || lists.size() == 0)
		{
            return null;
        }
        ArrayList<List<String>> arrayList = new ArrayList<>(lists);
        for (int i = 0; i < arrayList.size(); i++)
		{
            List<String> list = arrayList.get(i);
            // 去除空集合
            if (list == null || list.size() == 0)
			{
                arrayList.remove(list);
                i-- ;
            }
        }
        // 都是空集合，返回null
        if (arrayList.size() == 0)
		{
            return null;
        }
        List<String> intersection = arrayList.get(0) ;
        // 只有一个非空集合，结果就是它本身
        if (arrayList.size() == 1)
		{
            return intersection;
        }
        // 有多个非空集合，直接挨个求交集
        for (int i = 1; i < arrayList.size() - 1; i++)
		{
            intersection.retainAll(arrayList.get(i));
        }
        return intersection;
    }
	public static List<String> getIntersection(List<List<String>>... lists1)
	{
		List list2=Arrays.asList(lists1);
		return getIntersection_b(list2);
	}}
